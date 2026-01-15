// infrastructure/firestore_User_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/repositories/user_repo.dart';
import 'package:injectable/injectable.dart';

// Store each participants into an array
@LazySingleton(as: IUserRepository)
class FirestoreUserRepository implements IUserRepository {
  final FirebaseFirestore firestore;
  static const collectionPath = "users";

  FirestoreUserRepository() : firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, User>> fetchUsersByIds(Set<String> userIds) async {
    final result = <String, User>{};

    final ids = userIds.toList();

    for (var i = 0; i < ids.length; i += 10) {
      final batch = ids.sublist(i, (i + 10 > ids.length) ? ids.length : i + 10);

      final snapshot = await firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: batch)
          .get();

      for (final doc in snapshot.docs) {
        result[doc.id] = _fromDoc(doc);
      }
    }

    return result;
  }

  User _fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return User(
      uid: UserId(doc.id),
      displayName: data["displayName"],
      email: data["email"],
    );
  }
}
