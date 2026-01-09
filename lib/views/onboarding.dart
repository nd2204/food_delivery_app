import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  static const onboardingSlides = <Widget>[
    _Onboarding1(),
    _Onboarding1(),
    _Onboarding2(),
    _Onboarding3(),
  ];

  static int get slideCount => onboardingSlides.length;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentSlideIdx = 0;
  bool isFinalSlide = false;

  void nextSlide() {
    setState(() {
      currentSlideIdx = min(currentSlideIdx + 1, OnboardingPage.slideCount - 1);
      isFinalSlide = currentSlideIdx >= (OnboardingPage.slideCount - 1);
    });
  }

  Function()? getNextRouteCb(BuildContext context) {
    return () => Navigator.pushNamed(context, AppRoute.auth.name);
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    Function()? currentSlideBtnCallbackSwitch({
      Function()? callback,
      Function()? onFinalSlideCb,
    }) {
      return isFinalSlide ? onFinalSlideCb : callback;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: .end,
            children: [
              Expanded(child: OnboardingPage.onboardingSlides[currentSlideIdx]),
              Row(
                mainAxisSize: .max,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 4,
                      crossAxisAlignment: .stretch,
                      children: [
                        Row(
                          spacing: 8,
                          mainAxisSize: .min,
                          mainAxisAlignment: .center,
                          children: [
                            for (var i = 0; i < OnboardingPage.slideCount; i++)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: i == currentSlideIdx
                                      ? colorscheme.primary
                                      : colorscheme.primaryContainer,
                                ),
                              ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 60)),
                        FilledButton(
                          onPressed: currentSlideBtnCallbackSwitch(
                            callback: nextSlide,
                            onFinalSlideCb: getNextRouteCb(context),
                          ),
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isFinalSlide ? "GET STARTED" : "NEXT",
                            style: TextStyle(fontSize: 14, fontWeight: .w600),
                          ),
                        ),
                        TextButton(
                          onPressed: currentSlideBtnCallbackSwitch(
                            callback: getNextRouteCb(context),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isFinalSlide ? "" : "Skip",
                            style: TextStyle(color: colorscheme.onSecondary),
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
      ),
    );
  }
}

class _Onboarding1 extends StatelessWidget {
  const _Onboarding1();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      mainAxisAlignment: .center,
      children: [
        Row(
          mainAxisSize: .min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: OnboardingImage("assets/images/Onboarding1.png"),
            ),
          ],
        ),
        Column(
          spacing: 18,
          children: [
            OnboardingTitle("All your favorites"),
            OnboardingDescription(
              "Get all your loved foods in one once place"
              " you just place the order we do the rest",
            ),
          ],
        ),
      ],
    );
  }
}

class _Onboarding2 extends StatelessWidget {
  const _Onboarding2();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      mainAxisAlignment: .center,
      children: [
        Row(
          mainAxisSize: .min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: OnboardingImage("assets/images/Onboarding2.png"),
            ),
          ],
        ),
        Column(
          spacing: 18,
          children: [
            OnboardingTitle("Order from choosen chef"),
            OnboardingDescription(
              "Get all your loved foods in one once place"
              " you just place the order we do the rest",
            ),
          ],
        ),
      ],
    );
  }
}

class _Onboarding3 extends StatelessWidget {
  const _Onboarding3();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      mainAxisAlignment: .center,
      children: [
        Row(
          mainAxisSize: .min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: OnboardingImage("assets/images/Onboarding3.png"),
            ),
          ],
        ),
        Column(
          spacing: 18,
          children: [
            OnboardingTitle("Free delivery offers"),
            OnboardingDescription(
              "Get all your loved foods in one once place,"
              " you just place the order we do the rest",
            ),
          ],
        ),
      ],
    );
  }
}

class ImageFallback extends StatelessWidget {
  const ImageFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 294,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        border: null,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardingImage extends StatelessWidget {
  final String imagePath;

  const OnboardingImage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      width: 240,
      height: 294,
      fit: .cover,
      image: AssetImage(imagePath),
    );
  }
}

class OnboardingTitle extends Text {
  OnboardingTitle(super.data, {super.key})
    : super(
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF32343E),
          fontSize: 24,
        ),
      );
}

class OnboardingDescription extends Text {
  OnboardingDescription(super.data, {super.key})
    : super(
        style: TextStyle(fontSize: 16, color: Color(0xFF646982)),
        textAlign: .center,
      );
}
