class Config {

  static const apiKey = "API KEY";

  static const int maxPeriodDuration = 365; // days

  static final DateTime minDate = DateTime(DateTime.now().year - 1, DateTime.now().month);
  static final DateTime maxDate = DateTime(DateTime.now().year + 1, DateTime.now().month);

  const Config();

  static getApiUrl(String path) {
    return "https://api.raf.ninja/v1/" + path;
  }
}