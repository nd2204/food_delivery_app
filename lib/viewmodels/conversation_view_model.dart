import 'package:flutter/material.dart' hide Page;
import 'package:food_delivery_app/models/conversation/conversation.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/repositories/conversation_repo.dart';
import 'package:food_delivery_app/services/auth_service.dart';
import 'package:food_delivery_app/utils/injection.dart';
import 'package:food_delivery_app/utils/page.dart';

class ConversationViewModel extends ChangeNotifier {
  late final AuthService _authService;
  late final IConversationRepository _convoRepo;

  final List<Conversation> _cachedConversations = [];
  Page<Conversation>? _currentPage;

  ConversationViewModel() {
    _authService = getIt.get<AuthService>();
    _convoRepo = getIt.get<IConversationRepository>();
    final currentUser = _authService.getCurrentUser();
  }

  Future<List<Conversation>> fetchNextPage() async {
    // fetch new page (if doesn't exist)
    if (_currentPage == null) {
      final currentUser = _authService.getCurrentUser();
      if (currentUser == null) throw "User is not available";

      _currentPage = await _convoRepo.listByUserId(currentUser.uid);
    } else {
      if (_currentPage!.hasMore) {
        _currentPage = await _currentPage!.next();
      }
    }

    // add conversations to cache
    if (_currentPage != null) {
      final convos = _currentPage!.items;
      _cachedConversations.addAll(convos);
    }

    return _cachedConversations;
  }
}
