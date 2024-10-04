class PostModel{

  final int id;
  final String title;
  final double price;
  final String thumbnail;

  PostModel(
      {
        required this.id,
        required this.title,
        required this.price,
        required this.thumbnail
      });

  factory PostModel.fromJson(Map<String,dynamic>json){
    return PostModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        thumbnail: json['thumbnail']);
  }

}