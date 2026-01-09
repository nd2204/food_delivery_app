import 'package:flutter/material.dart';
import 'package:food_delivery_app/views/auth.dart';
import 'package:food_delivery_app/views/onboarding.dart';
import 'package:food_delivery_app/views/unknown.dart';

enum AppRoute {
  onboarding("/onboarding"),
  auth("/auth"),
  foodDetails("/food-details");

  final String name;

  const AppRoute(this.name);
}

final Map<String, dynamic> routes = {
  AppRoute.onboarding.name: (_) => const OnboardingPage(),
  AppRoute.auth.name: (_) => const AuthPage(),
  AppRoute.foodDetails.name: (_) => const AuthPage(),
};

Route<dynamic>? Function(RouteSettings)? generateRoute = (settings) {
  // if (settings.name == AppRoute.foodDetails.name) {
  // final foodId = settings.arguments as String; // e.g. "42"
  // return MaterialPageRoute(builder: (ctx) => On, settings: settings);
  // }

  if (routes.containsKey(settings.name)) {
    return MaterialPageRoute(builder: routes[settings.name]);
  }

  // Unknown route fallback
  return MaterialPageRoute(builder: (_) => const UnknownRoutePage());
};
