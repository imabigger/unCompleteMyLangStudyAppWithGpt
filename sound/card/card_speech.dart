import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:study_language_ai_flutter_project/sound/const.dart';
import 'package:study_language_ai_flutter_project/sound/model/sound_option_model.dart';

Future<void> makeCardSpeech(
    {required CardModel card,
    required LangStorageModel langStorageModel,
    required String directory,
    required SoundOptionModel soundOptionModel}) async {
  // 앱의 영구 저장소 경로를 가져옴
  String appDocPath = (await getApplicationDocumentsDirectory()).path;

  // 'directory'라는 하위 디렉토리를 생성
  Directory newDirectory = Directory('$appDocPath/$directory');
  if (!await newDirectory.exists()) {
    await newDirectory.create(); // 디렉토리가 없다면 생성
  }

  var response =
      await FirebaseFunctions.instance.httpsCallable('textToSpeech').call(
    {
      "text": langStorageModel.transString,
      "languageCode": soundOptionModel.languageCode,
      "name" : soundOptionModel.voiceName,
    },
  );

  var decodedAudio = base64Decode(response.data['audioContent']);

  // 디렉토리 안에 MP3 파일 저장
  File file = File(
      '$appDocPath/$directory/${langStorageModel.language.name}${card.cardUniqueId}.mp3');
  await file.writeAsBytes(decodedAudio);
}

Future<File?> findAudio(
    CardModel card, LangStorageModel langStorageModel, String directory) async {
  // 앱의 영구 저장소 경로를 가져옴
  String appDocPath = (await getApplicationDocumentsDirectory()).path;
  Directory dir = Directory('$appDocPath/$directory');

  if (!(await dir.exists())) {
    await dir.create(recursive: true);
  }

  // 디렉토리 내의 모든 파일을 가져옴
  List<FileSystemEntity> files = dir.listSync();

  // 특정 파일 이름과 일치하는 파일을 찾음
  for (FileSystemEntity file in files) {
    if (file is File &&
        file.path.endsWith(
            '/${langStorageModel.language.name}${card.cardUniqueId}.mp3')) {
      return file; //file.path하면 됨.
    }
  }
  return null; // 일치하는 파일을 찾지 못한 경우 null 반환
}

void playTTS(File file) async {

  // 오디오 플레이어 인스턴스 생성
  PlayerState? state = globalAudioPlayer.state;
  if (state != PlayerState.playing) {

    // 저장된 오디오 파일 재생
    await globalAudioPlayer.play(DeviceFileSource(file.path));
  }
}

//*** 삭제시 audio파일도 같이 삭제 cause --> 사용자가 관리 할 수 없는 위치!
void deleteAudioFile(File file) async {
  if (await file.exists()) {
    await file.delete();
    print('파일이 삭제되었습니다.');
  } else {
    print('해당 파일이 존재하지 않습니다.');
  }
}
