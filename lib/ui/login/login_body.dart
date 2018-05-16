import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/routes.dart';

class LoginBody extends StatefulWidget {

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance()
        .then((prefs) => _usernameController.text = prefs.getString("username") ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(Styles.Dimens.formPadding),
      children: <Widget>[
        Container(height: Styles.Dimens.dividerLarge),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: Styles.Dimens.logoRadius,
          child: Image(
            image: AssetImage("assets/img/logo.png"),
          ),
        ),
        Container(height: Styles.Dimens.dividerLarge),
        TextFormField(
          autofocus: false,
          controller: _usernameController,
          style: Styles.TextStyles.inputText,
          decoration: InputDecoration(
            hintText: "Korisničko ime",
            hintStyle: Styles.TextStyles.inputHint,
            prefixIcon: Icon(Icons.account_box),
            contentPadding: Styles.Dimens.inputPadding,
            filled: true,
            fillColor: Styles.Colors.inputFill,
            border: InputBorder.none,
          ),
        ),
        Container(height: Styles.Dimens.dividerSmall),
        TextFormField(
          autofocus: false,
          obscureText: true,
          controller: _passwordController,
          style: Styles.TextStyles.inputText,
          decoration: InputDecoration(
            hintText: "Lozinka",
            hintStyle: Styles.TextStyles.inputHint,
            prefixIcon: Icon(Icons.lock),
            contentPadding: Styles.Dimens.inputPadding,
            filled: true,
            fillColor: Styles.Colors.inputFill,
            border: InputBorder.none,
          ),
        ),
        Container(height: Styles.Dimens.dividerBig),
        Material(
          borderRadius: BorderRadius.circular(Styles.Dimens.buttonRadius),
          elevation: Styles.Dimens.elevation,
          child: MaterialButton(
              padding: Styles.Dimens.buttonPadding,
              onPressed: () => _login(),
              color: Styles.Colors.button,
              child: Text("Prijava", style: Styles.TextStyles.textFull)
          ),
        ),
      ],
    );
  }

  _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if(username.isEmpty || password.isEmpty) {
      Scaffold
          .of(context)
          .showSnackBar(SnackBar(
            backgroundColor: Styles.Colors.snackbar,
            content: Text("Popunite neophodna polja", style: Styles.TextStyles.snackbar)
            ),
          );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    prefs.setString("username", username);
    prefs.setString("password", password);

    Routes.navigate(context, "/home", true, Transition.start);
  }
}
