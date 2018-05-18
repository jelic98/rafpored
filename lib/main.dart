import 'package:flutter/material.dart';
import 'package:rafroid/core/res.dart' as Res;
import 'package:rafroid/core/routes.dart';
import 'package:rafroid/view/page/login/login_page.dart';

main() {
  Routes.initRoutes();
  runApp(MaterialApp(
    title: Res.Strings.app_name,
    home: LoginPage(),
  ));
}