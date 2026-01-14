import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_app/routes.dart';
import 'package:food_delivery_app/utils/injection.dart';
import 'package:food_delivery_app/viewmodels/login_view_model.dart';
import 'package:food_delivery_app/widgets/labeled_text_field.dart';
import 'package:food_delivery_app/widgets/password_field.dart';

class LoginFormTitle extends StatelessWidget {
  const LoginFormTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      spacing: 3,
      mainAxisSize: .max,
      children: [
        Text(
          "Log In",
          textAlign: .center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onTertiary,
            fontWeight: .bold,
            fontSize: 30,
          ),
        ),
        Text(
          "Please sign in to your existing account",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onTertiary,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class LoginFormBody extends StatelessWidget {
  final LoginViewModel _loginViewModel;

  LoginFormBody({super.key}) : _loginViewModel = getIt.get<LoginViewModel>();

  void _onFacebook() {
    print("onFacebook");
  }

  void _onGoogle() {
    print("onGoogle");
  }

  void _onApple() {
    print("onApple");
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Column(
          spacing: 24,
          crossAxisAlignment: .stretch,
          children: [
            LabeledTextField(
              label: "EMAIL",
              hintText: "example@gmail.com",
              controller: _loginViewModel.emailController,
            ),
            PasswordField(
              label: "PASSWORD",
              controller: _loginViewModel.passwordController,
              hintText: "Enter your password",
            ),
            Row(
              children: [
                _LoginCheckbox(loginViewModel: _loginViewModel),
                const SizedBox(width: 4),
                Text(
                  'Remember me',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoute.authForgotPassword.name,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: colors.primary, fontSize: 14),
                  ),
                ),
              ],
            ),

            _LoginButton(loginViewModel: _loginViewModel),

            // Signup
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 6),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.authSignup.name);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            // Alternative
            Column(
              children: [
                // "or" text
                Text(
                  'Or',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                // Social buttons row
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    _SocialButton(
                      icon: FontAwesomeIcons.facebookF,
                      background: const Color(0xFF1877F2),
                      onPressed: _onFacebook,
                    ),
                    _SocialButton(
                      icon: FontAwesomeIcons.apple,
                      background: Colors.black,
                      onPressed: _onApple,
                    ),
                    _SocialButton(
                      icon: FontAwesomeIcons.google,
                      background: Colors.white,
                      iconColor: Colors.black,
                      border: Border.all(color: Colors.black12),
                      onPressed: _onGoogle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  final LoginViewModel _loginViewModel;

  const _LoginButton({required LoginViewModel loginViewModel})
    : _loginViewModel = loginViewModel;

  void _onLogin(BuildContext context) async {
    final success = await _loginViewModel.signInWithEmailAndPassword(
      _loginViewModel.emailController.text,
      _loginViewModel.passwordController.text,
    );

    if (!context.mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, AppRoute.home.name);
    } else {
      final String errorMessage = _loginViewModel.errorMessage ?? "";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(milliseconds: 5000),
          width: 280.0, // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _loginViewModel,
      builder: (context, child) {
        final colors = Theme.of(context).colorScheme;
        final isLoading = _loginViewModel.isLoading;

        return FilledButton(
          onPressed: () => _onLogin(context),
          style: FilledButton.styleFrom(
            backgroundColor: (isLoading) ? colors.secondaryContainer : null,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: (isLoading)
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth:
                        2.5, // Thinner stroke looks better inside buttons
                    color: colors.onSecondaryContainer,
                  ),
                )
              : Text(
                  "LOG IN",
                  style: TextStyle(fontSize: 14, fontWeight: .w600),
                ),
        );
      },
    );
  }
}

class _LoginCheckbox extends StatelessWidget {
  const _LoginCheckbox({required LoginViewModel loginViewModel})
    : _loginViewModel = loginViewModel;

  final LoginViewModel _loginViewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _loginViewModel.rememberNotifier,
      builder: (context, value, child) {
        return Checkbox(
          value: value,
          onChanged: _loginViewModel.rememberNotifier.toggleRememberMe,
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        );
      },
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconColor;
  final Border? border;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.background,
    required this.onPressed,
    this.iconColor = Colors.white,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: border,
        ),
        child: Center(child: FaIcon(icon, size: 22, color: iconColor)),
      ),
    );
  }
}
