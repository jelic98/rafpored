import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/view/page/list/events_page.dart';
import 'package:rafpored/view/page/calendar/calendar_page.dart';
import 'package:rafpored/view/page/news/news_page.dart';
import 'package:rafpored/view/page/details/details_page.dart';
import 'package:rafpored/view/page/list/event_details.dart';
import 'package:rafpored/view/page/news/news_details.dart';

class Routes {

  static final Router _router = Router();

  static dynamic _bundle;

  static initRoutes() {
    _router.define(
        "/events",
        handler: Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return EventsPage();
            })
    );

    _router.define(
        "/calendar",
        handler: Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return CalendarPage();
            })
    );

    _router.define(
        "/news",
        handler: Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return NewsPage();
            })
    );

    _router.define(
        "/details-event",
        handler: Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return DetailsPage(EventDetails(_bundle));
            })
    );

    _router.define(
        "/details-news",
        handler: Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) {
              return DetailsPage(NewsDetails(_bundle));
            })
    );
  }

  static navigate(BuildContext context, String route, bool replace, {dynamic bundle}) {
    _bundle = bundle;
    _router.navigateTo(
        context,
        route,
        replace: replace,
        transition: TransitionType.fadeIn,
    );
  }
}