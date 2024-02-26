
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';
import 'package:study_language_ai_flutter_project/route/routes.dart';
//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive.registerAdapter<CardModel>(CardModelAdapter());
  Hive.registerAdapter<LangStorageModel>(LangStorageModelAdapter());
  Hive.registerAdapter<CardDetailModel>(CardDetailModelAdapter());
  Hive.registerAdapter<Lang>(LangAdapter());

  await Hive.openBox<String>('directory');
  await Hive.openBox<List>(card_box_name);
  await Hive.openBox<String>('lowSecurityRequired');
  await Hive.openBox<String>(upload_star_card_box);

  AudioPlayer globalAudioPlayer = AudioPlayer();

  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
