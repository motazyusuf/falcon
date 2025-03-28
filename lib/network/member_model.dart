class Products {
  List<Product> products;

  Products(this.products);

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      (json["products"] as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}

class Product {
  String title;
  double price;
  String imageURL;

  Product({required this.title, required this.price, required this.imageURL});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json["title"],
      price: json["price"],
      imageURL: json["images"][0],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "price": title,
      "images": [imageURL],
    };
  }
}
