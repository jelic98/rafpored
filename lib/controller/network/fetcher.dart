import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/config.dart';
import 'package:rafpored/core/utils.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';
import 'package:rafpored/controller/filter/filterable.dart';

abstract class Fetcher {

  static final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static List<dynamic> allItems;

  BuildContext _context;
  FetchListener _listener;

  fetch(BuildContext context, FetchListener listener) async {
    _context = context;
    _listener = listener;

    asyncFetch().then((items) => _onSuccess(items));
  }

  Future<String> getResponse(String endpoint) async {
    String response = await _getCache(endpoint);

    if(response == null || response.isNotEmpty) {
      if(await _hasNetwork()) {
        setCache(endpoint,
            response = (await Http.get(Config.getApiUrl(endpoint),
                headers: {"apikey" : Config.apiKey})).body);
      }else {
        if(response == null || response.isEmpty || response == "null") {
          _onError(Res.Strings.alertNoNetwork);
          return "{}";
        }
      }
    }

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

      if(now.difference(lastFetch).inMinutes < Config.cacheTimeout) {
        return lastFetchData;
      }
    }

    return null;
  }

  setCache(String endpoint, String data) {
    Fetcher.prefs.then((prefs) => prefs.setString("lastFetchData-$endpoint", data));
    Fetcher.prefs.then((prefs) => prefs.setString("lastFetchTime-$endpoint", DateTime.now().toString()));
  }

  _onSuccess(List<dynamic> items) {
    if(items.isNotEmpty && items[0] is Filterable) {
      allItems = items;
    }

    _listener.onFetched(items);
  }

  _onError(String message) {
    Utils.showMessage(_context, message);
    _onSuccess([]);
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