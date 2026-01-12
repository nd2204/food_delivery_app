import 'package:flutter/material.dart';

class AppBarController extends ValueNotifier<TopBarSpec> {
  AppBarController([super.value = const TopBarSpec()]);

  void set(TopBarSpec spec) => value = spec;

  void update({
    Widget? leading,
    Widget? title,
    Widget? trailing,
    Widget? background,
    bool? centerTitle,
    double? height,
    double? elevation,
    PreferredSizeWidget? bottom,
  }) {
    value = TopBarSpec(
      leading: leading ?? value.leading,
      title: title ?? value.title,
      trailing: trailing ?? value.trailing,
      centerTitle: centerTitle ?? value.centerTitle,
      background: background ?? value.background,
      elevation: elevation ?? value.elevation,
      bottom: bottom ?? value.bottom,
      height: height ?? value.height,
    );
  }
}

class TopBarSpec {
  const TopBarSpec({
    this.leading,
    this.title,
    this.trailing,
    this.centerTitle = false,
    this.height = 45,
    this.background,
    this.elevation,
    this.bottom,
    this.padding = const EdgeInsetsGeometry.all(0),
  });

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool centerTitle;
  final Widget? background;
  final double? elevation;
  final double height;
  final EdgeInsetsGeometry padding;
  final PreferredSizeWidget? bottom;
}

class AppBarScope extends InheritedNotifier<AppBarController> {
  const AppBarScope({
    super.key,
    required AppBarController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppBarController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppBarScope>();
    assert(scope != null, 'No AppBarScope found above in the tree.');
    return scope!.notifier!;
  }
}

class TopBarIconButton extends IconButton {
  TopBarIconButton({
    super.key,
    required super.onPressed,
    required super.icon,
    Color? backgroundColor = Colors.white,
  }) : super(
         style: IconButton.styleFrom(
           backgroundColor: backgroundColor,
           elevation: 2,
           shape: const CircleBorder(),
           fixedSize: const Size(45, 45),
         ),
       );
}

class TopBarContainer extends StatelessWidget {
  final TopBarSpec spec;
  const TopBarContainer({required this.spec, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: spec.height,
        child: Stack(
          children: [
            // Background layer (optional)
            if (spec.background != null)
              Positioned.fill(child: spec.background!),

            // Foreground content
            Padding(
              padding: spec.padding,
              child: Row(
                spacing: 8,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    children: [
                      Center(child: spec.leading),
                      spec.title != null
                          ? Padding(
                              padding: EdgeInsetsGeometry.only(left: 18),
                              child: spec.title,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: spec.trailing,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    required this.spec,
    required this.child,
    this.resetOnDispose = false,
    this.fallbackSpec,
  });

  final TopBarSpec spec;
  final Widget child;

  /// If true, reset to fallbackSpec when leaving this screen.
  final bool resetOnDispose;
  final TopBarSpec? fallbackSpec;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
    // Set after first frame so context is fully mounted.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      AppBarScope.of(context).set(widget.spec);
    });
  }

  @override
  void didUpdateWidget(covariant TopBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spec != widget.spec) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        AppBarScope.of(context).set(widget.spec);
      });
    }
  }

  @override
  void dispose() {
    if (widget.resetOnDispose && widget.fallbackSpec != null) {
      // No post frame here; we're going away anyway.
      AppBarScope.of(context).set(widget.fallbackSpec!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
