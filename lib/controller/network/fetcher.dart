import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as Http;
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/config.dart';
import 'package:rafpored/core/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';

abstract class Fetcher {

  static const int _cacheTimeout = 60 * 6; // minutes
  static final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static List<dynamic> allItems;

  fetch(BuildContext context, FetchListener listener) async {
    _hasNetwork().then((ok) =>
    (ok) ? asyncFetch().then((items)
    => _onSuccess(items, listener)) :
    _onError(context, Res.Strings.alertNoNetwork, listener));
  }

  Future<String> getResponse(String endpoint) async {
    String response = await _getCache(endpoint);

    if(response == null || response.isNotEmpty) {
      return (await Http.get(Config.getApiUrl(endpoint), headers: {"apikey" : Config.apiKey})).body;
    }

    setCache(endpoint, response);

    return response;
  }

  Future<String> _getCache(String endpoint) async {
    String lastFetchTime, lastFetchData;

    await prefs.then((prefs) => lastFetchTime = prefs.getString("lastFetchTime-$endpoint"));
    await prefs.then((prefs) => lastFetchData = prefs.getString("lastFetchData-$endpoint"));

    DateTime now = DateTime.now();

    if(lastFetchTime != null && lastFetchTime.isNotEmpty &&
        lastFetchData != null && lastFetchData.isNotEmpty) {
      DateTime lastFetch = DateTime.parse(lastFetchTime);

      if(now.difference(lastFetch).inMinutes < _cacheTimeout) {
        return lastFetchData;
      }
    }

    return null;
  }

  setCache(String endpoint, String data) {
    Fetcher.prefs.then((prefs) => prefs.setString("lastFetchData-$endpoint", data));
    Fetcher.prefs.then((prefs) => prefs.setString("lastFetchTime-$endpoint", DateTime.now().toString()));
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
  Future<List<dynamic>> asyncFetch();
}