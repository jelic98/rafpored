class Config {

  const Config();

  static getApiUrl(String path) {
    return "https://rfidis.raf.edu.rs/" + path;
  }
}