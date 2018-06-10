import 'package:flutter/material.dart';
import 'package:rafpored/core/config.dart';
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/view/page/list/events_page.dart';

main() {
  Routes.initRoutes();
  runApp(MaterialApp(
    title: Config.appName,
    home: EventsPage(),
  ));
}