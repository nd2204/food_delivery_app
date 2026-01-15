import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/top_bar.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBarController controller = AppBarController(TopBarSpec());

    return Scaffold(
      body: AppBarScope(
        controller: controller,
        child: Column(children: [TopBarContainer()]),
      ),
    );
  }
}
