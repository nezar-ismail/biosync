class BioConfig {
  static String ipAddress = '10.0.2.2';
  static String port = '5005';
  static get baseURL => '$ipAddress:$port';
}
