// infrastructure/firestore_conversation_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/conversation/conversation.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/utils/page.dart';
import 'package:injectable/injectable.dart';

import 'conversation_repo.dart';

// Store each participants into an array
@LazySingleton(as: IConversationRepository)
class FirestoreConversationRepository implements IConversationRepository {
  final FirebaseFirestore firestore;
  static const collectionPath = "conversations";

  FirestoreConversationRepository() : firestore = FirebaseFirestore.instance;

  @override
  Future<Conversation?> findById(ConversationId id) async {
    final doc = await firestore.collection(collectionPath).doc(id.value).get();

    if (!doc.exists) return null;

    return _fromDoc(doc);
  }

  @override
  Future<Conversation?> findByUsers(UserId a, UserId b) async {
    final query = await firestore
        .collection(collectionPath)
        .where('participants', arrayContains: [a.value, b.value])
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return _fromDoc(query.docs.first);
  }

  @override
  Future<Page<Conversation>> listByUserId(UserId uid, {int limit = 10}) async {
    return _fetchNextFromListByUserId(uid, limit: limit, lastDoc: null);
  }

  Future<Page<Conversation>> _fetchNextFromListByUserId(
    UserId uid, {
    required int limit,
    DocumentSnapshot? lastDoc,
  }) async {
    Query query = firestore
        .collection(collectionPath)
        .where('participants', arrayContains: uid.value)
        .limit(limit);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      lastDoc = snapshot.docs.last;
    }

    bool hasMore = true;
    if (snapshot.docs.length < limit) {
      hasMore = false;
    }

    final conversations = snapshot.docs.map(_fromDoc).toList();

    return Page(
      items: conversations,
      hasMore: hasMore,
      next: ([int? pageSize]) {
        return _fetchNextFromListByUserId(
          uid,
          limit: pageSize ?? limit,
          lastDoc: lastDoc,
        );
      },
    );
  }

  @override
  Future<void> save(Conversation conversation) async {
    final convoRef = FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(conversation.id.value);

    await convoRef.set({
      'participants': [conversation.userA.value, conversation.userB.value],
      'createdAt': Timestamp.fromDate(conversation.createdAt),
    }, SetOptions(merge: true));

    final batch = firestore.batch();

    for (final message in conversation.messages) {
      final msgRef = convoRef.collection('messages').doc(message.id.value);

      batch.set(msgRef, {
        'senderId': message.senderId.value,
        'text': message.content.text,
        'createdAt': Timestamp.fromDate(message.createdAt),
      }, SetOptions(merge: true));
    }

    await batch.commit();
  }

  Conversation _fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Conversation(
      id: ConversationId.from(doc.id),
      userA: UserId(data['participants'][0]),
      userB: UserId(data['participants'][1]),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
