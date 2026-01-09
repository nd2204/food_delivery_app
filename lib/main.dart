import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes.dart';
import 'package:food_delivery_app/views/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodDeliveryApp',
      initialRoute: "/onboarding",
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Sen",
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(
          primary: Color(0xFFFF7622),
          primaryContainer: Color(0xFFFFE1CE),
          secondary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF646982),
          tertiary: Color(0xFF121223),
          onTertiary: Color(0xFFFFFFFF),
          seedColor: Color(0xFFFF7622),
        ),
      ),
    );
  }
}
