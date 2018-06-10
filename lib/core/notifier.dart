import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/initialization_settings.dart';
import 'package:flutter_local_notifications/notification_details.dart';
import 'package:flutter_local_notifications/platform_specifics/android/initialization_settings_android.dart';
import 'package:flutter_local_notifications/platform_specifics/android/notification_details_android.dart';
import 'package:flutter_local_notifications/platform_specifics/ios/initialization_settings_ios.dart';
import 'package:flutter_local_notifications/platform_specifics/ios/notification_details_ios.dart';
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/core/config.dart';

class Notifier {

  static FlutterLocalNotificationsPlugin _plugin;
  static IOWebSocketChannel _channel;
  static BuildContext _context;

  static initNotifier(BuildContext context) {
    _context = context;

    _plugin = FlutterLocalNotificationsPlugin();
    _plugin.initialize(InitializationSettings(
        InitializationSettingsAndroid("mipmap/ic_launcher"),
        InitializationSettingsIOS()),
        selectNotification: _onNotificationClicked);

    _channel = IOWebSocketChannel.connect(Config.webSocket);
    _channel.stream.listen((snapshot) => _onNotificationReceived(snapshot));
  }

  static _notify(String title, String body) {
    _plugin.show(0, title, body,
        NotificationDetails(NotificationDetailsAndroid(
          Config.notificationChannelId,
          Config.notificationChannelName,
          Config.notificationChannelDescription,
        ), NotificationDetailsIOS()));
  }

  static _onNotificationReceived(String snapshot) {
    _notify(Res.Strings.captionNewsReceived,
        JsonDecoder().convert(snapshot)["message"]["title"] ??
            Res.Strings.actionOpenNews);
  }

  static Future _onNotificationClicked(String payload) async {
    Routes.navigate(_context, "/news", false, bundle: payload);
  }
}