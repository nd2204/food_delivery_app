import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/auth_service.dart';
import 'package:food_delivery_app/utils/injection.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _reTypeController = TextEditingController();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get reTypeController => _reTypeController;

  late final AuthService authService;

  SignUpViewModel() {
    authService = getIt.get<AuthService>();
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password) {
    _isLoading = true;
    notifyListeners();

    return authService
        .createUserWithEmailAndPassword(email, password)
        .whenComplete(() {
          _isLoading = false;
          notifyListeners();
        })
        .then((claim) {
          print(claim);
          return true;
        })
        .onError((e, trace) {
          _errorMessage = e.toString();
          return false;
        });
  }
}
