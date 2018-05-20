import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/view/page/login/login_page.dart';

main() {
  Routes.initRoutes();
  runApp(MaterialApp(
    title: Res.Strings.app_name,
    home: LoginPage(),
  ));
}