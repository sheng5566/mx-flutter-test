import 'package:equatable/equatable.dart';
import 'package:mxtest/products/domain/entities/rating.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  // Article({@required this.id, @required this.title, @required this.description, this.image, @required this.publishDate, this.tags});

  factory Product.fromJson(Map<String, dynamic> json) {
    var priceJson = json['price'];
    bool isInt = priceJson is int;
    double price = isInt ? (priceJson as int).toDouble() : priceJson as double;
    return Product(
        id: json['id'] as int,
        title: json['title'],
        price: price,
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: Rating.fromJson(json['rating']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating,
    };
  }

  @override
  List<Object> get props =>
      [id, title, price, description, category, image, rating];
}
