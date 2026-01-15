import 'package:food_delivery_app/models/user.dart';

abstract class AuthService {
  User? getCurrentUser();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Future<User> createUserWithEmailAndPassword(String email, String password);

  Future<void> updateDisplayName(String displayName);
}
