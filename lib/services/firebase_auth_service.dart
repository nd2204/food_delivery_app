import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:food_delivery_app/utils/errors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

extension AppUserFromFirebaseUser on fba.User {
  User toUser() {
    return User(
      displayName: displayName ?? '',
      email: email ?? '',
      uid: UserId(uid),
    );
  }
}

@LazySingleton(as: AuthService)
class FirebaseAuthService implements AuthService {
  const FirebaseAuthService();

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) {
    try {
      return fba.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((cred) => cred.user!.toUser());
    } on fba.FirebaseAuthException catch (e) {
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
  Future<User> signInWithEmailAndPassword(String email, String password) {
    try {
      return fba.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((cred) => cred.user!.toUser());
    } on fba.FirebaseAuthException catch (e) {
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
    return fba.FirebaseAuth.instance.signOut();
  }

  @override
  User? getCurrentUser() {
    return fba.FirebaseAuth.instance.currentUser?.toUser();
  }

  @override
  Future<void> updateDisplayName(String displayName) {
    return fba.FirebaseAuth.instance.currentUser!.updateDisplayName(
      displayName,
    );
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = fba.GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return fba.FirebaseAuth.instance.signInWithCredential(credential).then((
      cred,
    ) {
      if (cred.user == null) throw "user is null";
      return cred.user!.toUser();
    });
  }
}
