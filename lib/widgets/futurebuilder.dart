import 'package:flutter/material.dart';

import '../services/api_services.dart';
import '../views/post_details/post_details.dart';

class Futurebuilder extends StatefulWidget {
  const Futurebuilder({super.key});

  @override
  State<Futurebuilder> createState() => _FuturebuilderState();
}

class _FuturebuilderState extends State<Futurebuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data found'));
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.5, // Adjust height as needed
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(), // Enable GridView scrolling
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of columns to 2
              crossAxisSpacing: 5.0, // Space between columns
              mainAxisSpacing: 5.0, // Space between rows
              childAspectRatio: .90, // Adjust aspect ratio as needed
            ),
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetails(
                      postID: data.id.toString(),
                    ),
                  ),
                ),
                child: SizedBox(
                    // Set the height of each card
                  child: Card(
                    color: Colors.white70,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            data.thumbnail,
                            height: 80, // Fixed height for the image
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data.title,
                            maxLines: 2,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Price: ${data.price.toString()}', // Concatenate the text with the price
                            style: TextStyle(fontSize: 16), // You can adjust the style as needed
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
