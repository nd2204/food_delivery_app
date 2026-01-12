import 'package:flutter/material.dart';

class AppBarController extends ValueNotifier<TopBarSpec> {
  AppBarController([super.value = const TopBarSpec()]);

  void set(TopBarSpec spec) => value = spec;

  void update({
    Widget? leading,
    Widget? title,
    List<Widget>? actions,
    bool? centerTitle,
    Color? backgroundColor,
    double? elevation,
    PreferredSizeWidget? bottom,
  }) {
    value = TopBarSpec(
      leading: leading ?? value.leading,
      title: title ?? value.title,
      actions: actions ?? value.actions,
      centerTitle: centerTitle ?? value.centerTitle,
      backgroundColor: backgroundColor ?? value.backgroundColor,
      elevation: elevation ?? value.elevation,
      bottom: bottom ?? value.bottom,
    );
  }
}

class TopBarSpec {
  const TopBarSpec({
    this.leading,
    this.title,
    this.actions = const [],
    this.centerTitle = true,
    this.backgroundColor = Colors.transparent,
    this.elevation,
    this.bottom,
  });

  final Widget? leading;
  final Widget? title;
  final List<Widget> actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final double? elevation;
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
  TopBarIconButton({super.key, required super.onPressed, required super.icon})
    : super(
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 2,
          shape: const CircleBorder(),
          fixedSize: const Size(45, 45),
        ),
      );
}

class TopBarContainer extends StatelessWidget {
  const TopBarContainer({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.height = kToolbarHeight,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.background,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final double height;
  final EdgeInsets padding;

  /// Put anything here: transparent, blur, gradient, solid color...
  final Widget? background;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            // Background layer (optional)
            if (background != null) Positioned.fill(child: background!),

            // Foreground content
            Padding(
              padding: padding,
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(child: leading),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      child: title ?? const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: trailing,
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
