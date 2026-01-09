import 'package:flutter/material.dart';

abstract class AuthPageWidget extends StatelessWidget {
  final Widget? title;
  final Widget? body;

  const AuthPageWidget({super.key, this.title, this.body});
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorscheme.tertiary,
      body: Column(
        mainAxisSize: .max,
        mainAxisAlignment: .spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: colorscheme.onTertiary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends AuthPageWidget {
  const LoginForm({super.key, super.title, super.body});

  @override
  Widget build(BuildContext context) {
    return Column(children: []);
  }
}
