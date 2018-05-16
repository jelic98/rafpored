import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/ui/login/login_body.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/bg_login.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: Res.Dimens.bgBlur, sigmaY: Res.Dimens.bgBlur),
              child: LoginBody(),
            ),
          )
      );
}