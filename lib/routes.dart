import 'package:flutter/material.dart';
import 'package:food_delivery_app/views/auth.dart';
import 'package:food_delivery_app/views/home.dart';
import 'package:food_delivery_app/views/onboarding.dart';
import 'package:food_delivery_app/views/profile.dart';
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
  selected("/food"),
  message("/message"),
  profile("/profile"),
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

final Map<String, Widget Function()> routes = {
  AppRoute.onboarding.name: () => const OnboardingPage(),
  AppRoute.home.name: () => const HomePage(),
  AppRoute.search.name: () => const HomePage(),
  AppRoute.profile.name: () => const ProfilePage(),
};

Route<dynamic>? Function(RouteSettings)? generateRoute = (settings) {
  if (settings.name?.startsWith(AppRoute.auth.name) ?? false) {
    return MaterialPageRoute(
      builder: (_) => AuthPage(route: AppRoute.fromName(settings.name!)),
    );
  } else if (routes.containsKey(settings.name)) {
    return MaterialPageRoute(
      builder: (context) {
        return routes[settings.name]!();
      },
    );
  }

  // Unknown route fallback
  return MaterialPageRoute(builder: (_) => const UnknownRoutePage());
};
