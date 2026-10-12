import 'package:flutter/material.dart';

import 'features/shell/app_shell.dart';
import 'theme/app_theme.dart';

class FishNoteApp extends StatelessWidget {
  const FishNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fish Note',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const AppShell(),
    );
  }
}
