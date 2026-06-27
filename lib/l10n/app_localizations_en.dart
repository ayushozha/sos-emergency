// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SOS Emergency';

  @override
  String get callNow => 'Call now';

  @override
  String get imSafe => 'I\'m safe';

  @override
  String get shareLocation => 'Share location';

  @override
  String callingAutomatically(String number) {
    return 'Calling $number automatically';
  }
}
