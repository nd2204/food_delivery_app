import 'package:food_delivery_app/models/user.dart';

abstract class IUserRepository {
  Future<Map<String, User>> fetchUsersByIds(Set<String> userIds);
}
