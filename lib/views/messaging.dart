import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/top_bar.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarScope(
        controller: null,
        child: Column(
          children: [
            TopBarContainer(spec: spec)
          ],
        ),
      ),
    )
  }
}
