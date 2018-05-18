class Config {

  const Config();

  static getApiUrl(String path) {
    return "http://www.ecloga.org/" + path;
  }
}