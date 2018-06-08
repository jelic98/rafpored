class Config {

  static const apiKey = "API KEY";

  const Config();

  static getApiUrl(String path) {
    return "https://api.raf.ninja/v1/" + path;
  }
}