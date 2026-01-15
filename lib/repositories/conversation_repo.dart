import 'package:food_delivery_app/models/conversation/conversation.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/utils/page.dart';

abstract class IConversationRepository {
  Future<Conversation?> findById(ConversationId id);
  Future<Conversation?> findByUsers(UserId a, UserId b);
  Future<Page<Conversation>?> listByUserId(UserId uid, {int limit = 10});
  Future<void> save(Conversation conversation);
}
