import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future nextScreenMaterial(BuildContext context, Widget page) async {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplaceMaterial(BuildContext context, Widget page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => page));
}

void nextScreenCloseOthers(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenPopup(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(fullscreenDialog: true, builder: (context) => page),
  );
}

void nextScreenHero(BuildContext context, Widget page) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 700),
      reverseTransitionDuration: Duration(milliseconds: 550),
      pageBuilder: (context, animation, secondaryAnimation) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Interval(0, 0.5),
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: page,
        );
      },
    ),
  );
}
