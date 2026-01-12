import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/routes.dart';
import 'package:food_delivery_app/widgets/forgot_password.dart';
import 'package:food_delivery_app/widgets/login.dart';
import 'package:food_delivery_app/widgets/signup.dart';
import 'package:food_delivery_app/widgets/top_bar.dart';

class AuthPageWidget {
  late Widget title;
  late Widget body;

  AuthPageWidget(this.title, this.body);

  factory AuthPageWidget.getFormByRoute(AppRoute route) {
    switch (route) {
      case .auth:
        return .new(LoginFormTitle(), LoginFormBody());
      case .authLogin:
        return .new(LoginFormTitle(), LoginFormBody());
      case .authSignup:
        return .new(SignupFormTitle(), SignupFormBody());
      case .authVerify:
        return .new(LoginFormTitle(), LoginFormBody());
      case .authForgotPassword:
        return .new(ForgotPasswordFormTitle(), ForgotPasswordFormBody());
      default:
    }
    throw ArgumentError("Invalid auth route");
  }
}

class AuthPage extends StatefulWidget {
  final AppRoute route;

  const AuthPage({super.key, required this.route});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final AppBarController controller;

  @override
  void initState() {
    super.initState();
    controller = AppBarController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final AuthPageWidget form = .getFormByRoute(widget.route);

    return AppBarScope(
      controller: controller,
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, spec, child) {
          return Scaffold(
            backgroundColor: colorscheme.tertiary,
            body: Stack(
              children: [
                Positioned(
                  top: -130,
                  left: -130,
                  child: SvgPicture.asset(
                    "assets/svgs/auth-bg-decorator-1.svg",
                    colorFilter: ColorFilter.mode(
                      colorscheme.tertiaryContainer,
                      .srcIn,
                    ),
                  ),
                ),
                Positioned(
                  top: -90,
                  right: -100,
                  child: SvgPicture.asset(
                    "assets/svgs/auth-bg-decorator-2.svg",
                    colorFilter: ColorFilter.mode(
                      colorscheme.tertiaryContainer,
                      .srcIn,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: .max,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    SafeArea(
                      child: Column(
                        children: [
                          TopBarContainer(
                            leading: spec.leading,
                            title: spec.title,
                          ),
                          form.title,
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                            width: w,
                            decoration: BoxDecoration(
                              color: colorscheme.onTertiary,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: form.body,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
