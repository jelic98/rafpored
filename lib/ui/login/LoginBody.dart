import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;
import 'package:rafroid/Routes.dart';

class LoginBody extends StatefulWidget {

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.Colors.pageBackground,
      body: ListView(
        padding: EdgeInsets.all(Theme.Dimens.formPadding),
        children: <Widget>[
          Container(height: Theme.Dimens.dividerLarge),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Theme.Dimens.logoRadius,
            child: Image(
              image: AssetImage("assets/img/logo.png"),
            ),
          ),
          Container(height: Theme.Dimens.dividerLarge),
          TextFormField(
            autofocus: false,
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Korisničko ime',
              hintStyle: Theme.TextStyles.inputHint,
              contentPadding: Theme.Dimens.inputPadding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Theme.Dimens.inputRadius),
              ),
            ),
          ),
          Container(height: Theme.Dimens.dividerSmall),
          TextFormField(
            autofocus: false,
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Lozinka',
              hintStyle: Theme.TextStyles.inputHint,
              contentPadding: Theme.Dimens.inputPadding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Theme.Dimens.inputRadius),
              ),
            ),
          ),
          Container(height: Theme.Dimens.dividerBig),
          Material(
            borderRadius: BorderRadius.circular(Theme.Dimens.buttonRadius),
            elevation: Theme.Dimens.elevation,
            child: MaterialButton(
                padding: Theme.Dimens.buttonPadding,
                onPressed: () => login(),
                color: Theme.Colors.button,
                child: Text("Prijava", style: Theme.TextStyles.textFull)
            ),
          ),
        ],
      ),
    );
  }

  login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if(username.isEmpty || password.isEmpty) {
      return;
    }

    Routes.navigate(context, '/home', true, Transition.start)
  }
}
