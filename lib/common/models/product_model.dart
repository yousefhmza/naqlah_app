import '../../core/utils/constants.dart';

class Product {
  final String id;
  final String userId;
  final String name;
  final String category;
  final double pricePerUnit;
  final String priceUnit;
  final int minAmount;
  final int maxAmount;
  final List reviews;
  final List<dynamic> images;

  Product({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.pricePerUnit,
    required this.priceUnit,
    required this.minAmount,
    required this.maxAmount,
    required this.reviews,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"] ?? Constants.empty,
        userId: json["userId"] ?? Constants.empty,
        name: json["name"] ?? Constants.empty,
        category: json["category"] ?? Constants.empty,
        pricePerUnit: double.tryParse(json["price_per_unit"].toString()) ?? 0.0,
        priceUnit: json["unit"] ?? Constants.empty,
        minAmount: json["min_amount"] ?? 0,
        maxAmount: json["max_amount"] ?? 0,
        reviews: json["reviews"] ?? [],
        images: json["images"] ?? [],
      );
}
