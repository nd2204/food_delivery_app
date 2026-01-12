import 'package:flutter/material.dart';
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
          leading: TopBarIconButton(
            icon: Icon(Icons.chevron_left_rounded),
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

class SignupFormBody extends StatefulWidget {
  const SignupFormBody({super.key});

  @override
  State<SignupFormBody> createState() => _SignupFormBodyState();
}

class _SignupFormBodyState extends State<SignupFormBody> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController retypeController;
  bool remember = false;

  void _onSignup() {
    throw UnimplementedError();
  }

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    retypeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    retypeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              controller: nameController,
            ),
            LabeledTextField(
              label: "EMAIL",
              hintText: "example@gmail.com",
              controller: emailController,
            ),
            PasswordField(
              hintText: "Enter your password",
              controller: passwordController,
            ),
            PasswordField(
              label: "RE-TYPE PASSWORD",
              hintText: "Re-type your password",
              controller: retypeController,
            ),
          ],
        ),
        SafeArea(
          child: FilledButton(
            onPressed: _onSignup,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "SIGN UP",
              style: TextStyle(fontSize: 14, fontWeight: .bold),
            ),
          ),
        ),
      ],
    );
  }
}
