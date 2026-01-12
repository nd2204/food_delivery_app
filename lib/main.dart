import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    registerAppRoute();

    return MaterialApp(
      title: 'FoodDeliveryApp',
      initialRoute: AppRoute.onboarding.name,
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Sen",
        colorScheme: .fromSeed(
          onSurfaceVariant: Color(0xFF646982),
          primary: Color(0xFFFF7622),
          primaryContainer: Color(0xFFFFE1CE),
          secondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFF0F5FA),
          onSecondary: Color(0xFF646982),
          onSecondaryContainer: Color(0xFFA0A5BA),
          tertiary: Color(0xFF121223),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFF1E1E2E),
          seedColor: Color(0xFFFF7622),
        ),
      ),
    );
  }
}
