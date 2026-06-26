// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'SOS Emergencia';

  @override
  String get callNow => 'Llamar ahora';

  @override
  String get imSafe => 'Estoy a salvo';

  @override
  String get shareLocation => 'Compartir ubicación';

  @override
  String callingAutomatically(String number) {
    return 'Llamando a $number automáticamente';
  }
}
