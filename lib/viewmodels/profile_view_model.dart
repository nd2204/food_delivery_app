import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/services/auth_service.dart';
import 'package:food_delivery_app/utils/injection.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService;

  late final User? user = _authService.getCurrentUser();

  ProfileViewModel() : _authService = getIt.get<AuthService>();

  Future<void> signOut() {
    return _authService.signOut();
  }
}
