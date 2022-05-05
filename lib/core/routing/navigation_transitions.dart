import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

class NavigationFadeTransition extends PageRouteBuilder {
  final Widget screen;
  final Duration duration;

  NavigationFadeTransition(this.screen, {this.duration = Time.t300})
      : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (_, __, ___) => screen,
          transitionsBuilder: (_, animation, __, child) {
            final tween = Tween(begin: 0.0, end: 1.0);
            final animationCurve =
                CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final fadeAnimation = tween.animate(animationCurve);
            return FadeTransition(opacity: fadeAnimation, child: child);
          },
        );
}

class NavigationSlideTransition extends PageRouteBuilder {
  final Widget screen;
  final Duration duration;

  NavigationSlideTransition(this.screen, {this.duration = Time.t300})
      : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (_, __, ___) => screen,
          transitionsBuilder: (_, animation, __, child) {
            final slideTween =
                Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);
            final animationCurve =
                CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final slideAnimation = slideTween.animate(animationCurve);
            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
        );
}
