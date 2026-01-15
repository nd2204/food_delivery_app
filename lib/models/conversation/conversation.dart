import 'package:food_delivery_app/models/conversation/conversation_message.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class ConversationId {
  final String value;
  ConversationId._(this.value);

  factory ConversationId.newId() => ConversationId._(_uuid.v4());
  factory ConversationId.from(String id) => ConversationId._(_uuid.v4());
}

class Conversation {
  final ConversationId id;
  UserId userA;
  UserId userB;
  DateTime createdAt;
  DateTime lastActivityAt;
  final List<Message> _messages;
  List<Message> get messages => List.unmodifiable(_messages);

  Conversation({
    required this.id,
    required this.userA,
    required this.userB,
    required this.createdAt,
    List<Message>? messages,
    DateTime? lastActivityAt,
  }) : lastActivityAt = lastActivityAt ?? DateTime.now(),
       _messages = messages ?? [];

  factory Conversation.create({
    required ConversationId id,
    required UserId userA,
    required UserId userB,
  }) {
    if (userA == userB) {
      throw Exception("Cannot create conversation with self");
    }

    return Conversation(
      id: id,
      userA: userA,
      userB: userB,
      createdAt: DateTime.now(),
    );
  }

  bool isParticipant(UserId userId) => userId == userA || userId == userB;

  void _ensureParticipant(UserId userId) {
    if (!isParticipant(userId)) {
      throw Exception("User not in conversation");
    }
  }

  Message sendMessage(UserId senderId, MessageContent content) {
    _ensureParticipant(senderId);

    final message = Message.create(
      id: MessageId.newId(),
      senderId: senderId,
      content: content,
    );

    _messages.add(message);
    return message;
  }

  void updateActivity(String messageId) {
    lastActivityAt = DateTime.now();
  }
}
