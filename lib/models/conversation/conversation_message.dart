import 'package:food_delivery_app/models/user.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class Message {
  final MessageId id;
  final MessageContent content;
  final UserId senderId;
  final DateTime createdAt;
  DateTime? deliveredAt;
  DateTime? readAt;

  Message._({
    required this.id,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });

  factory Message.create({
    required MessageId id,
    required UserId senderId,
    required MessageContent content,
  }) {
    return Message._(
      id: id,
      senderId: senderId,
      content: content,
      createdAt: DateTime.now(),
    );
  }

  void markDelivered([DateTime? deliveredAt]) {
    deliveredAt = deliveredAt ?? DateTime.now();
    if (deliveredAt.isBefore(createdAt)) {
      throw Exception("deliveredAt must be after or equal sentAt");
    }

    this.deliveredAt = deliveredAt;
  }
}

class MessageId {
  final String value;
  MessageId._(this.value);

  factory MessageId.newId() => MessageId._(_uuid.v4());
  factory MessageId.from(String value) => MessageId._(value);
}

class MessageContent {
  final String text;

  MessageContent._(this.text);

  factory MessageContent.text(String value) {
    if (value.trim().isEmpty) {
      throw Exception("Message cannot be empty");
    }
    return MessageContent._(value);
  }
}
