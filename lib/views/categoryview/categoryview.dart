import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widgets/colors.dart';
import '../productcategorydetails/productcategorydetails.dart';

class Categoryview extends StatefulWidget {
  const Categoryview({super.key});

  @override
  State<Categoryview> createState() => _CategoryviewState();
}

class _CategoryviewState extends State<Categoryview> {
  List<String> myCategories = [];
  List<dynamic> products = [];
  bool isLoading = false;
  String selectedCategory = "All";
  String searchQuery = ""; // To store the search input

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchCategorieProducts("All");
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoading = true;
    });

    Uri url = Uri.parse("https://dummyjson.com/products");
    try {
      final response = await http.get(url);
      final List<dynamic> data = json.decode(response.body)["products"];

      final List<String> fetchedCategories = ["All"];

      for (var product in data) {
        final String category = product["category"];
        if (!fetchedCategories.contains(category)) {
          fetchedCategories.add(category);
        }
      }

      setState(() {
        myCategories = fetchedCategories;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchCategorieProducts(String category) async {
    setState(() {
      isLoading = true;
    });

    Uri url = Uri.parse("https://dummyjson.com/products");
    try {
      final response = await http.get(url);
      final List<dynamic> data = json.decode(response.body)["products"];

      final List<dynamic> categoriesProducts = [];

      for (var product in data) {
        final String productCategory = product["category"];
        if (category == "All" || productCategory == category) {
          categoriesProducts.add(product);
        }
      }

      setState(() {
        products = categoriesProducts;
        selectedCategory = category;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to search products based on query
  Future<void> searchProducts(String query) async {
    setState(() {
      isLoading = true;
    });

    Uri url = Uri.parse("https://dummyjson.com/products/search?q=$query");
    try {
      final response = await http.get(url);
      final List<dynamic> data = json.decode(response.body)["products"];

      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product",style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor: CustomColors.primarycolor,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for products...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (searchQuery.isNotEmpty) {
                      searchProducts(searchQuery); // Fetch search results
                    }
                  },
                ),
                // Adding a rounded border to the TextField
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                    // You can customize the border color
                  ),
                ),
                // Adding a border when the TextField is focused
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.blue, // You can customize the focused border color
                    width: 2.0, // You can customize the width of the focused border
                  ),
                ),
              ),
              onChanged: (value) {
                searchQuery = value; // Store the search query
              },
            ),

          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: myCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = myCategories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                        fetchCategorieProducts(category);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: selectedCategory == category
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                          fontWeight: selectedCategory == category
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? Center(child: Text('No products available for this category.'))
                : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product["thumbnail"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(product["title"]),
                  subtitle: Text("\$${product["price"]}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductCategoryDetails(
                          title: product["title"],
                          description: product["description"] ??
                              "No description available.",
                          imageUrl: product["thumbnail"],
                          price: product["price"].toDouble(),
                          rating: product["rating"].toDouble(),
                          discountPercentage:
                          product["discountPercentage"]
                              .toDouble(),
                          stock: product["stock"],
                          brand: product["brand"],
                          sku: product["sku"],
                          weight: product["weight"].toDouble(),
                          dimensions: {
                            'width': product["dimensions"]["width"],
                            'height':
                            product["dimensions"]["height"],
                            'depth': product["dimensions"]["depth"],
                          },
                          warrantyInformation:
                          product["warrantyInformation"],
                          shippingInformation:
                          product["shippingInformation"],
                          availabilityStatus:
                          product["availabilityStatus"],
                          reviews: List<Map<String, dynamic>>.from(
                              product["reviews"]),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
