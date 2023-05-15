class ImageConstants {
  static const logo = "assets/images/logo.png";
}

class URLConstants {
  URLConstants._();

  static const baseURLStart = String.fromEnvironment('BASE_URL');
  static const isfaBaseURL = '$baseURLStart/iSFA';
  static const apiBaseUrl = "$isfaBaseURL/api";
  static const loginAuth = "$apiBaseUrl/auth";
}
