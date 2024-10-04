import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/post_details_model.dart';
import '../../services/api_services.dart';
import '../../widgets/colors.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/favoritesprovider.dart';


class PostDetails extends StatefulWidget {
  final String postID;
  const PostDetails({super.key, required this.postID});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<PostDetailsModel?>(
          future: ApiServices.getSinglePost(widget.postID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Center(
                child: Text('Error fetching data'),
              );
            } else {
              final post = snapshot.data!;
              bool isFavorite = favoritesProvider.isFavorite(widget.postID);

              return ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            favoritesProvider.removeFavorite(widget.postID);
                          } else {
                            favoritesProvider.addFavorite(widget.postID);
                          }
                        },
                      ),
                    ],
                  ),
                  Image.network(post.thumbnail),
                  const SizedBox(height: 8),
                  Text(
                    post.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(post.description, style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 8),
                  Text('Category: ${post.category}'),
                  Text('Rating: ${post.rating ?? 'No rating available'}'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Price: ${post.price}'),
                      Text('Discount: ${post.discountPercentage ?? 'No discount available'}', style: const TextStyle(fontSize: 14)),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: CustomColors.primarycolor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(child: CustomText(text: 'Order', color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Reviews:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...post.reviews.map((review) {
                    return ListTile(
                      title: Text(review.reviewerName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rating: ${review.rating}'),
                          Text('Comment: ${review.comment}'),
                          Text('Date: ${review.date}'),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
