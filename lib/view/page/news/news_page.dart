import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/config.dart';
import 'package:rafpored/controller/notifier/notifier_page.dart';
import 'package:rafpored/view/common/back_bar.dart';
import 'package:rafpored/view/page/news/news_body.dart';

class NewsPage extends NotifierPage {

  @override
  NotifierPageState createState() => NewsPageState();
}

class NewsPageState extends NotifierPageState {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            BackBar(Config.appName),
            NewsBody(),
          ],
        ),
      );
}