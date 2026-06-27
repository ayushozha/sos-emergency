import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/sos_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Landscape lock applies to iPad / Android tablets; web ignores it.
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  runApp(const ProviderScope(child: SosApp()));
}
