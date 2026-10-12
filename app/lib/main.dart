import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/db/app_database.dart';
import 'data/db/connection.dart';
import 'data/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final db = AppDatabase(openConnection());
  runApp(ProviderScope(
    overrides: [databaseProvider.overrideWithValue(db)],
    child: const FishNoteApp(),
  ));
}
