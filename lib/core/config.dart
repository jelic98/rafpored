class Config {

  static const String appName = "Rafpored";

  static const apiKey = "API KEY";
  static const webSocket = "wss://api.raf.ninja/websocket";

  static const String notificationChannelId = "rafpored_channel";
  static const String notificationChannelName = appName;
  static const String notificationChannelDescription = "Channel for receiving news";

  static const int cacheTimeout = 60 * 6; // minutes
  static const int maxPeriodDuration = 365; // days

  static final DateTime minDate = DateTime(DateTime.now().year - 1, DateTime.now().month);
  static final DateTime maxDate = DateTime(DateTime.now().year + 1, DateTime.now().month);

  const Config();

  static getApiUrl(String path) {
    return "https://api.raf.ninja/v1/" + path;
  }
}