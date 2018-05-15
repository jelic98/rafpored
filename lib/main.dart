import 'package:flutter/material.dart';
import 'package:rafroid/Routes.dart';
import 'package:rafroid/ui/calendar/CalendarPage.dart';

void main() {
  Routes.initRoutes();
  runApp(new MaterialApp(
    title: "Rafpored",
    home: new CalendarPage(),
  ));
}