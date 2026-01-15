import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/conversation_list_view.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: ConversationListView()));
  }
}
