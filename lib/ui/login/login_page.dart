import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/ui/login/login_body.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/bg_login.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: Styles.Dimens.bgBlur, sigmaY: Styles.Dimens.bgBlur),
            child: LoginBody(),
          ),
        )
    );
  }
}