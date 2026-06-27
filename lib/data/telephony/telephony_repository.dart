/// Placing and ending emergency calls, abstracted from the platform dialer
/// (iOS/Android `tel:` intents via `url_launcher`). Live emergency services
/// can't be tested, so the default impl is a sandbox that records dials.
abstract interface class TelephonyRepository {
  Future<void> dial(String number);
  Future<void> hangUp();
}

/// Test-mode telephony: records every dialled number to a log sink instead of
/// calling a real network. Used everywhere until a vetted platform impl ships.
class SandboxTelephonyRepository implements TelephonyRepository {
  final List<String> dialed = [];
  bool callActive = false;

  @override
  Future<void> dial(String number) async {
    dialed.add(number);
    callActive = true;
  }

  @override
  Future<void> hangUp() async {
    callActive = false;
  }
}
