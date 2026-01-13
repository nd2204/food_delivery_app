class UserClaims {}

abstract class AuthService {
  Future<UserClaims> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Future<UserClaims> createUserWithEmailAndPassword(
    String email,
    String password,
  );
}
