import 'package:flutter/material.dart';

import '../../widgets/colors.dart';
import '../../widgets/custom_text.dart';

class OrderView extends StatefulWidget {
  final String title;
  final double price;
  final String imageUrl;

  // Constructor to accept title, price, and imageUrl
  OrderView({
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int quantity = 1; // Default quantity

  // Calculate total price based on quantity
  double get totalPrice => widget.price * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4.0, // Controls the shadow depth
              margin: EdgeInsets.all(16.0), // Adds margin around the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Rounds the corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Adds padding inside the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        widget.imageUrl,
                        height: 100, // Adjust the height as needed
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Product Title: ${widget.title}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Price per item: \$${widget.price.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity:",
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Total Price: \$${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: CustomColors.primarycolor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // Shadow color
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: CustomText(text: 'Checkout', color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}