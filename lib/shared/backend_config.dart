/// Compile-time backend URL for API transport.
abstract final class BackendConfig {
  static const String url = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'http://localhost:8000',
  );

  static bool get isConfigured => url.isNotEmpty;

  /// Set `--dart-define=USE_BACKEND=true` to call compose/voice APIs.
  static const bool useBackend = bool.fromEnvironment(
    'USE_BACKEND',
    defaultValue: false,
  );

  static Uri get baseUri => Uri.parse(url);
}