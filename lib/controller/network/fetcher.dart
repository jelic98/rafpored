import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';

abstract class Fetcher {

  static const int _cacheTimeout = 0;
  // todo static const int _cacheTimeout = 60 * 6; // minutes
  static final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static List<dynamic> allItems;

  fetch(BuildContext context, FetchListener listener) {
    _checkCache(context, listener);
  }

  _checkCache(BuildContext context, FetchListener listener) async {
    String lastFetchTime, lastFetchData;

    await prefs.then((prefs) => lastFetchTime = prefs.getString("lastFetchTime"));
    await prefs.then((prefs) => lastFetchData = prefs.getString("lastFetchData"));

    DateTime now = DateTime.now();

    if(lastFetchTime != null && lastFetchTime.isNotEmpty &&
        lastFetchData != null && lastFetchData.isNotEmpty) {
      DateTime lastFetch = DateTime.parse(lastFetchTime);

      if(now.difference(lastFetch).inMinutes < _cacheTimeout) {
        asyncFetch(lastFetchData).then((events) => _onSuccess(events, listener));
        return;
      }
    }

    _hasNetwork().then((ok) =>
    (ok) ? asyncFetch().then((events)
    => _onSuccess(events, listener)) :
    _onError(context, Res.Strings.alertNoNetwork, listener));

    prefs.then((prefs) => prefs.setString("lastFetchTime", now.toString()));
  }

  _onSuccess(List<dynamic> items, FetchListener listener) {
    allItems = items;
    listener.onFetched(items);
  }

  _onError(BuildContext context, String message, FetchListener listener) {
    Utils.showMessage(context, message);
    _onSuccess([], listener);
  }

  Future<bool> _hasNetwork() async {
    try {
      final result = await InternetAddress.lookup("google.com");

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    }on SocketException catch(_) {
      return false;
    }
  }

  int sort(dynamic a, dynamic b);
  Future<List<dynamic>> asyncFetch([String data]);
}