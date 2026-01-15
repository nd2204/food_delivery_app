import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restautrant.dart';
import 'package:food_delivery_app/widgets/restaurant_list_view.dart';
import 'package:food_delivery_app/widgets/top_bar.dart';

class RestaurantPage extends StatelessWidget {
  final Restaurant _restaurant;

  const RestaurantPage({super.key, required Restaurant restaurant})
    : _restaurant = restaurant;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final appBarController = AppBarController(
      TopBarSpec(
        leading: TopBarIconButton(
          backgroundColor: colors.surfaceContainer,
          icon: Icon(Icons.chevron_left_rounded, color: colors.tertiary),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            debugPrint("Selected: $value");
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: "chat", child: Text("Open chat")),
          ],
          child: TopBarIconButton(
            onPressed: null,
            backgroundColor: colors.surfaceContainer,
            icon: Icon(Icons.more_horiz, color: colors.tertiary),
          ),
        ),
        title: const Text("Restaurant View", style: TextStyle(fontSize: 17)),
      ),
    );

    return Scaffold(
      body: AppBarScope(
        controller: appBarController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              TopBarContainer(),
              const SizedBox(height: 24),
              RestaurantCard(restaurant: _restaurant),
            ],
          ),
        ),
      ),
    );
  }
}
