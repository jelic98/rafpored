import 'package:flutter/material.dart';
import 'package:rafpored/controller/notifier/notifier.dart';

abstract class NotifierPage extends StatefulWidget {

  @override
  NotifierPageState createState();
}

abstract class NotifierPageState extends State<NotifierPage>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) {
      Notifier.initNotifier(context);
    }else if(state == AppLifecycleState.paused) {
      Notifier.closeNotifier();
    }
  }

  @override
  Widget build(BuildContext context);
}