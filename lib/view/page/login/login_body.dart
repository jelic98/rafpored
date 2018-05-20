import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/core/utils.dart';
import 'package:rafpored/view/page/login/login_enter_animation.dart';

class LoginBody extends StatefulWidget {

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody>
    with SingleTickerProviderStateMixin {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginEnterAnimation _animation;

  @override
  void initState() {
    super.initState();

    _prefs.then((prefs) => _loadCredentials(prefs));

    _animation = LoginEnterAnimation(
        AnimationController(
          duration: const Duration(milliseconds: 5000),
          vsync: this,
        )..forward()
    );
  }

  @override
  Widget build(BuildContext context) =>
      AnimatedBuilder(
        animation: _animation.controller,
        builder: (context, child) => ListView(
          padding: EdgeInsets.all(Res.Dimens.formPadding),
          children: <Widget>[
            Container(height: Res.Dimens.dividerLarge),
            ScaleTransition(
              scale: _animation.logoScale,
              child: Container(
                width: Res.Dimens.logoSize,
                height: Res.Dimens.logoSize,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image(
                    image: AssetImage("assets/img/logo.png"),
                  ),
                ),
              ),
            ),
            Container(
                height: (MediaQuery.of(context).orientation == Orientation.portrait)
                    ?  Res.Dimens.dividerLarge : 0.0
            ),
            SlideTransition(
              position: _animation.usernameSlide,
              child: TextFormField(
                autofocus: false,
                controller: _usernameController,
                style: Res.TextStyles.inputText,
                decoration: InputDecoration(
                  hintText: Res.Strings.input_username,
                  hintStyle: Res.TextStyles.inputHint,
                  prefixIcon: Icon(Icons.account_box),
                  contentPadding: Res.Dimens.inputPadding,
                  filled: true,
                  fillColor: Res.Colors.inputFill,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(height: Res.Dimens.dividerSmall),
            SlideTransition(
              position: _animation.passwordSlide,
              child: TextFormField(
                autofocus: false,
                obscureText: true,
                controller: _passwordController,
                style: Res.TextStyles.inputText,
                decoration: InputDecoration(
                  hintText: Res.Strings.input_password,
                  hintStyle: Res.TextStyles.inputHint,
                  prefixIcon: Icon(Icons.lock),
                  contentPadding: Res.Dimens.inputPadding,
                  filled: true,
                  fillColor: Res.Colors.inputFill,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(height: Res.Dimens.dividerBig),
            FadeTransition(
              opacity: _animation.buttonFade,
              child: Material(
                borderRadius: BorderRadius.circular(Res.Dimens.buttonRadius),
                elevation: Res.Dimens.buttonElevation,
                child: MaterialButton(
                    padding: Res.Dimens.buttonPadding,
                    onPressed: () => _login(),
                    color: Res.Colors.primaryDark,
                    child: Text(Res.Strings.action_login, style: Res.TextStyles.textFull)
                ),
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _animation.controller.dispose();

    super.dispose();
  }

  _loadCredentials(SharedPreferences prefs) {
    String username = prefs.getString("username") ?? "";
    String password = prefs.getString("password") ?? "";

    _usernameController.text = prefs.getString("username");
    _passwordController.text = prefs.getString("password");

    if(username.isNotEmpty && password.isNotEmpty) {
      _login();
    }
  }

  _saveCredentials(SharedPreferences prefs) {
    prefs.setString("username", _usernameController.text);
    prefs.setString("password", _passwordController.text);
  }

  _login() async {
    if(_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      Utils.showMessage(context, Res.Strings.alert_required_fields);
      return;
    }

    Utils.showMessage(context, Res.Strings.alert_wait);

    Future.delayed(Duration(milliseconds: 2000)).then((_) {
      _prefs.then((prefs) => _saveCredentials(prefs));
      Routes.navigate(context, "/list", true);
    });
  }
}