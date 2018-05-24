import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/view/page/list/list_page.dart';

main() {
  Routes.initRoutes();
  runApp(MaterialApp(
    title: Res.Strings.appName,
    home: ListPage(),
  ));
}