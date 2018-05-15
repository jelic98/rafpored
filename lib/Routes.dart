import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:rafroid/ui/calendar/CalendarPage.dart';

class Routes {

  static final Router _router = new Router();

  static void initRoutes() {
    _router.define("/calendar", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
		return new CalendarPage();
      })
	);
  }

  static void navigateTo(context, String route, {TransitionType transition}) {
    _router.navigateTo(context, route, transition: transition);
  }
}
