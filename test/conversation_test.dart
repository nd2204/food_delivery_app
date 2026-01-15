import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/models/conversation/conversation.dart';
import 'package:food_delivery_app/models/conversation/conversation_message.dart';
import 'package:food_delivery_app/models/user.dart';

void main() {
  group('Conversation', () {
    test('creates a valid one-to-one conversation', () {
      final userA = UserId('user-a');
      final userB = UserId('user-b');

      final conversation = Conversation.create(
        id: ConversationId.newId(),
        userA: userA,
        userB: userB,
      );

      expect(conversation.userA, equals(userA));
      expect(conversation.userB, equals(userB));
      expect(conversation.messages, isEmpty);
    });

    test('throws when creating conversation with same user', () {
      final user = UserId('user-a');

      expect(
        () => Conversation.create(
          id: ConversationId.newId(),
          userA: user,
          userB: user,
        ),
        throwsException,
      );
    });

    test('participant can send a message', () {
      final userA = UserId('user-a');
      final userB = UserId('user-b');

      final conversation = Conversation.create(
        id: ConversationId.newId(),
        userA: userA,
        userB: userB,
      );

      final message = conversation.sendMessage(
        userA,
        MessageContent.text('Hello'),
      );

      expect(conversation.messages.length, 1);
      expect(message.senderId, userA);
      expect(message.content.text, 'Hello');
      expect(message.createdAt, isNotNull);
    });

    test('non-participant cannot send a message', () {
      final userA = UserId('user-a');
      final userB = UserId('user-b');
      final intruder = UserId('user-x');

      final conversation = Conversation.create(
        id: ConversationId.newId(),
        userA: userA,
        userB: userB,
      );

      expect(
        () => conversation.sendMessage(
          intruder,
          MessageContent.text('I should not be here'),
        ),
        throwsException,
      );
    });

    test('empty message is rejected', () {
      final userA = UserId('user-a');
      final userB = UserId('user-b');

      final conversation = Conversation.create(
        id: ConversationId.newId(),
        userA: userA,
        userB: userB,
      );

      expect(
        () => conversation.sendMessage(userA, MessageContent.text('   ')),
        throwsException,
      );
    });
  });
}
