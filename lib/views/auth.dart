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
        return .new(SignupFormTitle(), SignUpFormBody());
      case .authVerify:
        return .new(LoginFormTitle(), LoginFormBody());
      case .authForgotPassword:
        return .new(ForgotPasswordFormTitle(), ForgotPasswordFormBody());
      default:
    }
    throw ArgumentError("Invalid auth route");
  }
}

class AuthPage extends StatelessWidget {
  final AppBarController _appBarController = AppBarController();
  final AppRoute _route;

  AuthPage({super.key, required AppRoute route}) : _route = route;

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final AuthPageWidget form = .getFormByRoute(_route);

    return AppBarScope(
      controller: _appBarController,
      child: Scaffold(
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
                      ValueListenableBuilder(
                        valueListenable: _appBarController,
                        builder: (context, spec, child) {
                          return TopBarContainer(spec: spec);
                        },
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
      ),
    );
  }
}
