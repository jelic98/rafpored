import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:rafroid/ui/login/LoginPage.dart';
import 'package:rafroid/ui/home/HomePage.dart';
import 'package:rafroid/ui/calendar/CalendarPage.dart';
import 'package:rafroid/ui/details/DetailsPage.dart';

class Routes {

  static final Router _router = new Router();

  static void initRoutes() {
    _router.define(
        "/login",
        handler: new Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return new LoginPage();
            })
    );

    _router.define(
        "/home",
        handler: new Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return new HomePage();
            })
    );

    _router.define(
        "/calendar",
        handler: new Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return new CalendarPage();
            })
    );

    _router.define(
        "/details/:id",
        handler: new Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return new DetailsPage(params["id"]);
            })
    );
  }

  static void navigate(BuildContext context, String route, bool replace, Transition type) {
    _router.navigateTo(
        context,
        route,
        replace: replace,
        transition: (type == Transition.start) ? TransitionType.inFromRight : TransitionType.inFromLeft,
    );
  }
}

enum Transition {
  start, exit
}