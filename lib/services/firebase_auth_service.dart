import 'package:food_delivery_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/utils/errors.dart';
import 'package:injectable/injectable.dart';

extension FirebaseUserClaims on UserCredential {
  UserClaims toUserClaims() {
    return UserClaims();
  }
}

@LazySingleton(as: AuthService)
class FirebaseAuthService implements AuthService {
  const FirebaseAuthService();

  @override
  Future<UserClaims> createUserWithEmailAndPassword(
    String email,
    String password,
  ) {
    try {
      return FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((cred) => cred.toUserClaims());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthenticationError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthenticationError('The account already exists for that email.');
      }
    } catch (e) {
      return Future.error(e);
    }

    // Unlikely
    throw AuthenticationError();
  }

  @override
  Future<UserClaims> signInWithEmailAndPassword(String email, String password) {
    try {
      return FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((cred) => cred.toUserClaims());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthenticationError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthenticationError('Wrong password provided for that user.');
      }
    }

    // Unlikely
    throw AuthenticationError();
  }

  @override
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
}
