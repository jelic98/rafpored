class Config {

  static const apiKey = "API KEY";
  static const int maxPeriodDuration = 365;

  const Config();

  static getApiUrl(String path) {
    return "https://api.raf.ninja/v1/" + path;
  }
}