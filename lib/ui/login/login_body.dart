import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/routes.dart';
import 'package:rafroid/utils.dart';
import 'package:rafroid/ui/login/login_enter_animation.dart';

class LoginBody extends StatefulWidget {

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody>
    with SingleTickerProviderStateMixin {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginEnterAnimation _animation;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) => _loadCredentials(prefs));

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
        builder: (context, child) => _buildContent(),
      );

  _loadCredentials(SharedPreferences prefs) {
    String username = prefs.getString("username") ?? "";
    String password = prefs.getString("password") ?? "";

    _usernameController.text = prefs.getString("username");
    _passwordController.text = prefs.getString("password");

    if(username.isNotEmpty && password.isNotEmpty) {
      _login();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _animation.controller.dispose();
  }

  _saveCredentials(SharedPreferences prefs) {
    prefs.setString("username", _usernameController.text);
    prefs.setString("password", _passwordController.text);
  }

  _login() async {
    if(_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      Utils.showMessage(context, "Popunite neophodna polja");
      return;
    }

    Utils.showMessage(context, "Molimo sačekajte");

    Future.delayed(Duration(milliseconds: 2000)).then((_) {
      SharedPreferences.getInstance().then((prefs) => _saveCredentials(prefs));
      Routes.navigate(context, "/list", true);
    });
  }

  Widget _buildContent() =>
      ListView(
        padding: EdgeInsets.all(Res.Dimens.formPadding),
        children: <Widget>[
          Container(height: Res.Dimens.dividerLarge),
          ScaleTransition(
            scale: _animation.logoScale,
            child: Container(
              width: Res.Dimens.logoSize,
              height: Res.Dimens.logoSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Res.Colors.logoBorder),
              ),
              padding: EdgeInsets.all(Res.Dimens.logoPadding),
              child: CircleAvatar(
                child: Image(
                  image: AssetImage("assets/img/logo.png"),
                ),
              ),
            ),
          ),
          Container(height: Res.Dimens.dividerLarge),
          SlideTransition(
            position: _animation.usernameSlide,
            child: TextFormField(
              autofocus: false,
              controller: _usernameController,
              style: Res.TextStyles.inputText,
              decoration: InputDecoration(
                hintText: "Korisničko ime",
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
                hintText: "Lozinka",
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
              elevation: Res.Dimens.elevation,
              child: MaterialButton(
                  padding: Res.Dimens.buttonPadding,
                  onPressed: () => _login(),
                  color: Res.Colors.button,
                  child: Text("Prijava", style: Res.TextStyles.textFull)
              ),
            ),
          ),
        ],
      );
}