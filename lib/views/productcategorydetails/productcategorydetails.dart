import 'package:flutter/material.dart';
import '../../widgets/colors.dart'; // Make sure this is imported if you use custom colors
import '../../widgets/custom_text.dart';
import '../order_view/OrderView.dart'; // Make sure this is imported if you use custom text widgets

class ProductCategoryDetails extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final double discountPercentage;
  final int stock;
  final String brand;
  final String sku;
  final double weight;
  final Map<String, double> dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<dynamic> reviews;

  ProductCategoryDetails({
    required String? title,
    required String? description,
    required String? imageUrl,
    required double? price,
    required double? rating,
    double? discountPercentage,
    int? stock,
    String? brand,
    String? sku,
    double? weight,
    Map<String, double>? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    required this.reviews,
  })  : this.title = title ?? 'Unknown Title',
        this.description = description ?? 'No description available.',
        this.imageUrl = imageUrl ?? 'https://via.placeholder.com/150',
        this.price = price ?? 0.0,
        this.rating = rating ?? 0.0,
        this.discountPercentage = discountPercentage ?? 0.0,
        this.stock = stock ?? 0,
        this.brand = brand ?? 'Unknown Brand',
        this.sku = sku ?? 'Unknown SKU',
        this.weight = weight ?? 0.0,
        this.dimensions = dimensions ?? {'width': 0.0, 'height': 0.0, 'depth': 0.0},
        this.warrantyInformation = warrantyInformation ?? 'No warranty information available.',
        this.shippingInformation = shippingInformation ?? 'No shipping information available.',
        this.availabilityStatus = availabilityStatus ?? 'Availability not specified';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              Image.network(imageUrl),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price: \$${price.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to OrderView when the button is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderView(title: title, price: price, imageUrl: imageUrl), // Replace with your OrderView widget
                            ),
                          );
                        },
                        child: Container(
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
                            child: CustomText(text: 'Order', color: Colors.white),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),

              SizedBox(height: 8),
              Text(
                "Rating: ${rating.toStringAsFixed(1)} ★",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Discount: $discountPercentage%",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Stock: $stock units available",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Brand: $brand",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "SKU: $sku",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Weight: ${weight}g",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Dimensions: ${dimensions['width']} x ${dimensions['height']} x ${dimensions['depth']} cm",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Warranty: $warrantyInformation",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Shipping Info: $shippingInformation",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Availability: $availabilityStatus",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Divider(),
              Text(
                "Reviews",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ListTile(
                    title: Text(review["reviewerName"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rating: ${review["rating"]} ★"),
                        Text(review["comment"]),
                        Text("Date: ${DateTime.parse(review["date"]).toLocal()}"),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
