import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/auth_service.dart';
import 'package:food_delivery_app/utils/injection.dart';
import 'package:injectable/injectable.dart';

class RememberNotifier extends ValueNotifier<bool> {
  RememberNotifier(super.value);

  // Toggle checkbox state
  void toggleRememberMe(bool? value) {
    super.value = value ?? !super.value;
    notifyListeners();
  }
}

@injectable
class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final RememberNotifier _rememberedNotifier = RememberNotifier(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  RememberNotifier get rememberNotifier => _rememberedNotifier;

  late final AuthService authService;

  LoginViewModel() {
    authService = getIt.get<AuthService>();
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) {
    _isLoading = true;
    notifyListeners();

    return authService
        .signInWithEmailAndPassword(email, password)
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
