class UserClaims {
  final String displayName;
  final String email;

  UserClaims({required this.displayName, required this.email});
}

abstract class AuthService {
  UserClaims? getCurrentUser();

  Future<UserClaims> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Future<UserClaims> createUserWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> updateDisplayName(String displayName);
}
