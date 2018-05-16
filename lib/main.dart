import 'package:flutter/material.dart';
import 'package:rafroid/routes.dart';
import 'package:rafroid/ui/calendar/calendar_page.dart';
import 'package:rafroid/ui/list/list_page.dart';
import 'package:rafroid/ui/login/login_page.dart';

main() {
  Routes.initRoutes();
  runApp(MaterialApp(
    title: "Rafpored",
    home: LoginPage(),
  ));
}