import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'features/history/domain/decision_record.dart';
import 'features/saved_lists/domain/saved_list.dart';
import 'hive_registrar.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();

  await Hive.openBox('settings');
  await Hive.openBox<SavedList>('saved_lists');
  await Hive.openBox<DecisionRecord>('history');

  runApp(const ProviderScope(child: DilioApp()));
}
