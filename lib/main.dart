import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/sos_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // The emergency Surface is landscape-only on iPad / Android tablets.
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const ProviderScope(child: SosApp()));
}
