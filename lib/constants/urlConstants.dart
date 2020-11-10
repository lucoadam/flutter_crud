class UrlConstants {
  //constants for rapidApi
  static var baseUrl = 'https://hms.stsolutions.com.np/api';
  static var baseHeaderHostKey = 'x-rapidapi-host';
  static var baseHeaderApiKey = 'x-rapidapi-key';
  static var baseHeaderHostValue = 'coronavirus-monitor.p.rapidapi.com';
  static var baseHeaderApiValue =
      '7f65f938fdmshe79a752d1f4c200p118c41jsnd41e69bff049';

  static String getLoginUrl() {
    return '$baseUrl/v1/auth/login/';
  }

  static String getCurrentUser() {
    return '$baseUrl/auth/user';
  }

  static String getAffectedCountriesUrl() {
    return '$baseUrl/affected.php';
  }

  static String getHistoryByParticularCountryUrl() {
    return '$baseUrl/cases_by_particular_country.php';
  }

  static String getCasesByCountryUrl() {
    return '$baseUrl/cases_by_country.php';
  }

  static String getLatestCoranaStatByCountryNameUrl() {
    return '$baseUrl/latest_stat_by_country.php';
  }

  static String getWorldTotalCoranaStatUrl() {
    return '$baseUrl/worldstat.php';
  }

  static String getContactUrl() {
    return 'https://webhosttestforimage.000webhostapp.com/demo.php';
  }

  static String getBookUrl() {
    // return 'http://10.0.3.2:8000?keyData=books';
    return 'https://webhosttestforimage.000webhostapp.com/demo.php?keyData=books';
  }
}
