import 'package:flutter/material.dart';
import 'package:food_delivery_app/views/auth.dart';
import 'package:food_delivery_app/views/home.dart';
import 'package:food_delivery_app/views/onboarding.dart';
import 'package:food_delivery_app/views/unknown.dart';

final Map<String, AppRoute> _registered = {};

enum AppRoute {
  onboarding("/onboarding"),
  auth("/auth"),
  authLogin("/auth/login"),
  authSignup("/auth/signup"),
  authVerify("/auth/verify"),
  authForgotPassword("/auth/recover"),
  home("/home"),
  search("/search"),
  foodDetails("/food-details");

  final String name;

  const AppRoute(this.name);

  static AppRoute fromName(String name) {
    return _registered[name]!;
  }
}

void registerAppRoute() {
  for (var r in AppRoute.values) {
    _registered[r.name] = r;
  }
}

final Map<String, dynamic> routes = {
  AppRoute.onboarding.name: (_) => const OnboardingPage(),
  AppRoute.home.name: (_) => const HomePage(),
  AppRoute.search.name: (_) => const HomePage(),
};

Route<dynamic>? Function(RouteSettings)? generateRoute = (settings) {
  if (settings.name?.startsWith(AppRoute.auth.name) ?? false) {
    return MaterialPageRoute(
      builder: (_) => AuthPage(route: AppRoute.fromName(settings.name!)),
    );
  }

  if (routes.containsKey(settings.name)) {
    return MaterialPageRoute(builder: routes[settings.name]);
  }

  // Unknown route fallback
  return MaterialPageRoute(builder: (_) => const UnknownRoutePage());
};
