import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery_app/utils/injection.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  configureDependencies();

  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    registerAppRoute();

    // FirebaseAuth.instance.signOut();

    return MaterialApp(
      title: 'FoodDeliveryApp',
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AppRoute.onboarding.name
          : AppRoute.home.name,
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Sen",
        colorScheme: .fromSeed(
          surfaceContainer: Color(0xFFECF0F4),
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
