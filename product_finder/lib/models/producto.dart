class Product {
  final String name;
  final String imageUrl;
  final String description;
  final String price;
  final String url;

  Product(
      {required this.name,
      required this.imageUrl,
      required this.description,
      required this.price,
      required this.url});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      price: json['price'],
      url: json['url'],
    );
  }
}
