import 'package:flutter/material.dart';

class LoginEnterAnimation {

  final AnimationController controller;

  final Animation<double> logoScale;
  final Animation<double> buttonFade;

  final Animation<Offset> usernameSlide;
  final Animation<Offset> passwordSlide;

  LoginEnterAnimation(this.controller) :
        logoScale = Tween(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.elasticInOut,
            ),
          ),
        ),
        usernameSlide = Tween(begin: Offset(-1.1, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.35,
              curve: Curves.linear,
            ),
          ),
        ),
        passwordSlide = Tween(begin: Offset(1.1, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.35,
              curve: Curves.linear,
            ),
          ),
        ),
        buttonFade = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.3,
              curve: Curves.easeIn,
            ),
          ),
        );
}