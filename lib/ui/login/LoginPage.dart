import 'package:flutter/material.dart';
import 'package:rafroid/ui/login/LoginBody.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new LoginBody(),
      ),
    );
  }
}