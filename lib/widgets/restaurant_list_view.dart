import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restautrant.dart';
import 'package:food_delivery_app/routes.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({super.key});

  final List<Restaurant> restaurants = const [
    Restaurant(
      name: "Rose Garden Restaurant",
      categories: "Burger · Chicken · Rice · Wings",
      rating: 4.7,
      delivery: "Free",
      time: "20 min",
    ),
    Restaurant(
      name: "Urban Food House",
      categories: "Pizza · Pasta · Drinks",
      rating: 4.5,
      delivery: "Free",
      time: "25 min",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: restaurants.length,
      separatorBuilder: (_, _) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return RestaurantCard(restaurant: restaurants[index]);
      },
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoute.restaurant.name,
            arguments: restaurant,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFB0BEC5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              restaurant.name,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              restaurant.categories,
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                _InfoItem(
                  icon: Icons.star,
                  iconColor: Colors.orange,
                  text: restaurant.rating.toString(),
                ),
                const SizedBox(width: 16),
                _InfoItem(
                  icon: Icons.delivery_dining,
                  iconColor: Colors.orange,
                  text: restaurant.delivery,
                ),
                const SizedBox(width: 16),
                _InfoItem(
                  icon: Icons.access_time,
                  iconColor: Colors.orange,
                  text: restaurant.time,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
