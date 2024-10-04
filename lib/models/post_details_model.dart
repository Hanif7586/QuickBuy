// post_details_model.dart

class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

class Meta {
  String? barcode;

  Meta({this.barcode});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      barcode: json['barcode'] != null ? json['barcode'].toString() : null,
    );
  }
}

class PostDetailsModel {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final String category;
  final double price;
  final String? rating; // Nullable rating field
  final String? discountPercentage;
  final Meta meta;
  final List<Review> reviews; // Add this line to include reviews

  PostDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.price,
    this.rating,
    this.discountPercentage,
    required this.meta,
    required this.reviews, // Add this line
  });

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) {
    var reviewList = json['reviews'] as List;
    List<Review> reviews = reviewList.map((reviewJson) => Review.fromJson(reviewJson)).toList();

    return PostDetailsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      category: json['category'],
      price: json['price'],
      rating: json['rating'] != null ? json['rating'].toString() : null,
      discountPercentage: json['discountPercentage'] != null ? json['discountPercentage'].toString() : null,
      meta: Meta.fromJson(json['meta']),
      reviews: reviews, // Initialize the reviews list
    );
  }
}
