import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes.dart';
import 'package:food_delivery_app/viewmodels/signup_view_model.dart';
import 'package:food_delivery_app/widgets/labeled_text_field.dart';
import 'package:food_delivery_app/widgets/password_field.dart';
import 'package:food_delivery_app/widgets/top_bar.dart';

class SignupFormTitle extends StatelessWidget {
  const SignupFormTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TopBar(
        spec: TopBarSpec(
          padding: const EdgeInsetsGeometry.only(left: 24),
          leading: TopBarIconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const SizedBox(height: 25),
            Text(
              "Sign Up",
              textAlign: .center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontWeight: .bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              "Please sign up to get started",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpFormBody extends StatelessWidget {
  final SignUpViewModel _signUpViewModel;

  SignUpFormBody({super.key}) : _signUpViewModel = SignUpViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .stretch,
      children: [
        Column(
          spacing: 24,
          crossAxisAlignment: .stretch,
          children: [
            LabeledTextField(
              label: "NAME",
              hintText: "john doe",
              controller: _signUpViewModel.nameController,
            ),
            LabeledTextField(
              label: "EMAIL",
              hintText: "example@gmail.com",
              controller: _signUpViewModel.emailController,
            ),
            PasswordField(
              label: 'PASSWORD',
              hintText: "Enter your password",
              controller: _signUpViewModel.passwordController,
            ),
            PasswordField(
              label: "RE-TYPE PASSWORD",
              hintText: "Re-type your password",
              controller: _signUpViewModel.reTypeController,
            ),
          ],
        ),
        SafeArea(child: _SignupButton(signUpViewModel: _signUpViewModel)),
      ],
    );
  }
}

class _SignupButton extends StatelessWidget {
  final SignUpViewModel _signUpViewModel;

  const _SignupButton({required SignUpViewModel signUpViewModel})
    : _signUpViewModel = signUpViewModel;

  void _onSignup(BuildContext context) async {
    final success = await _signUpViewModel.createUserWithEmailAndPassword(
      email: _signUpViewModel.emailController.text,
      password: _signUpViewModel.passwordController.text,
      displayName: _signUpViewModel.nameController.text,
    );

    if (!context.mounted) return;
    if (success) {
      Navigator.of(context).pushReplacementNamed(AppRoute.home.name);
    } else {
      final String errorMessage = _signUpViewModel.errorMessage ?? "";
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
      listenable: _signUpViewModel,
      builder: (context, child) {
        return FilledButton(
          onPressed: () => _onSignup(context),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "SIGN UP",
            style: TextStyle(fontSize: 14, fontWeight: .bold),
          ),
        );
      },
    );
  }
}
