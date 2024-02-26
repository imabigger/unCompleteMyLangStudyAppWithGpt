import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/component/drop_button.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/sound/const.dart';
import 'package:study_language_ai_flutter_project/sound/provider/sound_option_provider.dart';

class UserSoundSelectPage extends ConsumerStatefulWidget {
  const UserSoundSelectPage({super.key});

  @override
  ConsumerState<UserSoundSelectPage> createState() => _UserSoundSelectPageState();
}

class _UserSoundSelectPageState extends ConsumerState<UserSoundSelectPage> {
  final box = Hive.box<String>('lowSecurityRequired');

  late List<String> languageCountry;

  String? selectedCountry;
  String? selectedVoice;

  @override
  void initState() {
    // TODO: implement initState
    languageCountry = VoiceAudioToLangMap.entries
        .where((element) => element.value == box.get(tolang_save_key))
        .map((e) => e.key)
        .toList();

    super.initState();

    final currentOption = ref.read(ttsOptionProvider);

    if(currentOption != null){
      selectedVoice = currentOption.vg;
      selectedCountry = VoiceAudioLangToCode.entries.firstWhere((element) => element.value == currentOption.languageCode).key;
    }


  }

  @override
  Widget build(BuildContext context) {
    List<String> voiceNames = voicenameTolangcountry.entries
        .where((element) => element.value == selectedCountry)
        .map((e) => e.key)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red, //change your color here
        ),
        title: Text(
          'tts 설정',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 24.0,
          ),
          Text('현재 선택된 language : ${box.get(tolang_save_key)}'),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropDownButtonCustom<String>(
              value: selectedCountry,
              onChanged: (String? value) {
                setState(() {
                  selectedCountry = value;
                });
              },
              hintText: '세부 country 선택',
              items: languageCountry,
              valueToString: (String val) {
                return val;
              },
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropDownButtonCustom<String>(
              value: selectedVoice,
              onChanged: (String? value) {
                setState(() {
                  selectedVoice = value;
                });
              },
              hintText: 'voice 종류 선택',
              items: voiceNames,
              valueToString: (String val) {
                return val;
              },
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextButton(
            onPressed: () {
              final languageCode = VoiceAudioLangToCode[selectedCountry];
              if(languageCode != null && selectedVoice != null) {
                final voiceName = selectedVoice!.split(' ');
                ref.read(ttsOptionProvider.notifier).updateTTSOption(languageCode: languageCode, voiceName: voiceName[0], vg: selectedVoice!);
                context.pop();
              }
            },
            child: Text('Submit'),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }
}
