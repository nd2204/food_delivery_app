import 'package:food_delivery_app/models/user.dart';

class Restaurant {
  final String name;
  final String categories;
  final double rating;
  final String delivery;
  final String time;
  final UserId? owner;

  const Restaurant({
    required this.name,
    required this.categories,
    required this.rating,
    required this.delivery,
    required this.time,
    this.owner,
  });
}
