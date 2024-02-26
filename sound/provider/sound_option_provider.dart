


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_language_ai_flutter_project/sound/model/sound_option_model.dart';

final ttsOptionProvider = StateNotifierProvider<TTSOptionStateNotifier, SoundOptionModel?>((ref) {
  return TTSOptionStateNotifier();
});



class TTSOptionStateNotifier extends StateNotifier<SoundOptionModel?> {

  TTSOptionStateNotifier() : super(null);

  void updateTTSOption({
    required String languageCode,
    required String voiceName,
    required String vg,
}){
    state = SoundOptionModel(languageCode: languageCode, voiceName: voiceName,vg: vg);
  }

  void deleteTTSOption(){
    state= null;
  }
}
