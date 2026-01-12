import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_app/routes.dart';
import 'package:food_delivery_app/widgets/labeled_text_field.dart';
import 'package:food_delivery_app/widgets/password_field.dart';
import 'package:food_delivery_app/widgets/social_button.dart';

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

class LoginFormBody extends StatefulWidget {
  const LoginFormBody({super.key});

  @override
  State<LoginFormBody> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool remember = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onChanged(bool? value) {
    setState(() {
      remember = value ?? remember;
    });
  }

  void _onLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.home.name);
  }

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
              controller: emailController,
            ),
            PasswordField(controller: passwordController),
            Row(
              children: [
                Checkbox(
                  value: remember,
                  onChanged: _onChanged,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
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
            FilledButton(
              onPressed: () => _onLogin(context),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "LOG IN",
                style: TextStyle(fontSize: 14, fontWeight: .w600),
              ),
            ),

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
                    SocialButton(
                      icon: FontAwesomeIcons.facebookF,
                      background: const Color(0xFF1877F2),
                      onPressed: _onFacebook,
                    ),
                    SocialButton(
                      icon: FontAwesomeIcons.apple,
                      background: Colors.black,
                      onPressed: _onApple,
                    ),
                    SocialButton(
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
