import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes.dart';
import 'package:food_delivery_app/widgets/category_list_view.dart';
import 'package:food_delivery_app/widgets/restaurant_list_view.dart';
import 'package:food_delivery_app/widgets/search_bar.dart';
import 'package:food_delivery_app/widgets/top_bar.dart';

const name = "Halal";
const locationName = "$name Lab Office";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final AppBarController appBarController = AppBarController(
      buildTopBarSpec(context, colors),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AppBarScope(
          controller: appBarController,
          child: Column(
            children: [
              TopBarContainer(),
              const SizedBox(height: 24),
              const _HomeGreetText(),
              const SizedBox(height: 16),
              AppSearchBar(
                controller: null,
                onTap: () => Navigator.pushNamed(context, AppRoute.search.name),
                hintText: 'Search dishes, restaurants',
              ),
              const SizedBox(height: 32),
              _HomeLabel("All Categories", onPressed: () {}),
              const SizedBox(height: 20),
              const CategoryListView(),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    _HomeLabel("Open Restaurants", onPressed: () {}),
                    const SizedBox(height: 20),
                    Expanded(child: RestaurantListView()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TopBarSpec buildTopBarSpec(BuildContext context, ColorScheme colors) {
    return TopBarSpec(
      leading: TopBarIconButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.profile.name);
        },
        backgroundColor: colors.surfaceContainer,
        icon: Icon(Icons.menu_rounded, color: colors.tertiary),
      ),
      title: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        children: [
          Text(
            style: TextStyle(
              color: colors.primary,
              fontSize: 12,
              fontWeight: .bold,
            ),
            "DELIVER TO",
          ),
          const Text(style: TextStyle(fontSize: 14), locationName),
          // TODO: add dropdown
        ],
      ),
      trailing: TopBarIconButton(
        onPressed: () {},
        backgroundColor: colors.tertiary,
        icon: Icon(Icons.shopping_bag, color: colors.onTertiary),
      ),
    );
  }
}

class _HomeLabel extends StatelessWidget {
  final String data;
  final VoidCallback? onPressed;

  const _HomeLabel(this.data, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(data, style: TextStyle(fontSize: 20)),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(foregroundColor: colors.onSurface),
          child: Row(
            children: [
              const Text(
                "See All",
                style: TextStyle(fontSize: 16, fontWeight: .normal),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeGreetText extends StatelessWidget {
  const _HomeGreetText();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 16),
            children: [
              TextSpan(text: 'Hey $name, '),
              const TextSpan(
                text: 'Good Afternoon!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
