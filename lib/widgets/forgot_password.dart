import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/labeled_text_field.dart';
import 'package:food_delivery_app/widgets/top_bar.dart';

class ForgotPasswordFormTitle extends StatelessWidget {
  const ForgotPasswordFormTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return TopBar(
      spec: TopBarSpec(
        padding: const EdgeInsetsGeometry.only(left: 24),
        leading: TopBarIconButton(
          icon: Icon(Icons.chevron_left_rounded),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      child: Column(
        mainAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          const SizedBox(height: 25),
          Text(
            "Forgot Password",
            textAlign: .center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontWeight: .bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Please sign in to your existing account",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordFormBody extends StatefulWidget {
  const ForgotPasswordFormBody({super.key});

  @override
  State<ForgotPasswordFormBody> createState() => _ForgotPasswordFormBodyState();
}

class _ForgotPasswordFormBodyState extends State<ForgotPasswordFormBody> {
  final emailController = TextEditingController();
  bool remember = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _onChanged(bool? value) {
    setState(() {
      remember = value ?? remember;
    });
  }

  void _onSent() {}

  @override
  Widget build(BuildContext context) {
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

            FilledButton(
              onPressed: _onSent,
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "SENT CODE",
                style: TextStyle(fontSize: 14, fontWeight: .w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
