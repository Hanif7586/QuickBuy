import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/post_details_model.dart';
import '../../services/api_services.dart';
import '../../widgets/colors.dart';
import '../../widgets/favoritesprovider.dart';

 // Service to fetch product details

class FavoriteProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite",style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor: CustomColors.primarycolor,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favoritesProvider.favoriteProducts.length,
        itemBuilder: (context, index) {
          String productId = favoritesProvider.favoriteProducts[index];

          // Use FutureBuilder to fetch product details from an API or database
          return FutureBuilder<PostDetailsModel?>(
            future: ApiServices.getSinglePost(productId), // Handle nullable PostDetailsModel
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading product'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No product found'));
              } else {
                final product = snapshot.data!;
                return Card(
                  child: ListTile(
                    leading: Image.network(product.thumbnail), // Display thumbnail
                    title: Text(product.title), // Display title
                    subtitle: Text('Price: \$${product.price}'), // Display price
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        favoritesProvider.removeFavorite(product.id.toString()); // Ensure ID is converted to string
                      },
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
