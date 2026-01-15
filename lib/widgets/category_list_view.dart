import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food_category.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  final List<FoodCategory> categories = const [
    FoodCategory(name: "Pizza"),
    FoodCategory(name: "Burger"),
    FoodCategory(name: "Chicken"),
    FoodCategory(name: "Rice"),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // critical: fixed height for horizontal ListView
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _CategoryItem(category: categories[index]);
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final FoodCategory category;

  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          category.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
