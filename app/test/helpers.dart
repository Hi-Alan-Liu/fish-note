import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fish_note/app.dart';
import 'package:fish_note/data/db/app_database.dart';
import 'package:fish_note/data/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

AppDatabase memoryDb() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase(NativeDatabase.memory());
}

/// Opens (and seeds) the database outside the fake-async zone of testWidgets.
Future<AppDatabase> openedMemoryDb() async {
  final db = memoryDb();
  await db.allCategories();
  return db;
}

Future<void> pumpFishNote(WidgetTester tester, AppDatabase db, {DateTime Function()? clock}) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(ProviderScope(
    overrides: [
      databaseProvider.overrideWithValue(db),
      if (clock != null) clockProvider.overrideWithValue(clock),
    ],
    child: const FishNoteApp(),
  ));
  await tester.pumpAndSettle();
}

/// Lets real async DB work finish, then flushes streams and animations.
Future<void> settle(WidgetTester tester) async {
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
  await tester.pumpAndSettle();
}

Future<void> disposeFishNote(WidgetTester tester, AppDatabase db) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(milliseconds: 10));
  await tester.runAsync(db.close);
}
