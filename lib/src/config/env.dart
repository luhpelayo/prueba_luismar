class Env {
  static const Map<String, String> _keys = {
    'API_ENDPOINT': String.fromEnvironment('API_ENDPOINT'),
    'API_GOOGLEMAPS': String.fromEnvironment('API_GOOGLEMAPS'),
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('$key is not set in Env');
    }
    return value;
  }

  static String get apiEndpoint => _getKey('API_ENDPOINT');
  static String get apiGooglemaps => _getKey('API_GOOGLEMAPS');
}
