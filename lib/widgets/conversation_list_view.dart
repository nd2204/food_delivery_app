import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/conversation/conversation.dart';
import 'package:food_delivery_app/viewmodels/conversation_view_model.dart';

class ConversationListView extends StatelessWidget {
  final ConversationViewModel _viewModel;

  ConversationListView({super.key}) : _viewModel = ConversationViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _viewModel.fetchNextPage(),
      builder: (context, asyncSnapshot) {
        print(asyncSnapshot.data);
        if (asyncSnapshot.data == null) {
          return Text("Data not avaiable");
        } else {
          return ListView(
            children: [
              for (final convo in asyncSnapshot.data!)
                ConversationTile(item: convo),
            ],
          );
        }
      },
    );
  }
}

class ConversationTile extends StatelessWidget {
  final Conversation item;

  const ConversationTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to chat screen
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar + online indicator
            Stack(
              children: [
                const CircleAvatar(radius: 24, backgroundColor: Colors.white),
                // TODO: fetch online status
                if (true)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // Name + last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // TODO: fetch users name
                    item.userB.value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Last message",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Time + unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateTime.now().toLocal().toString(),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 6),
                if (true)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      6.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
