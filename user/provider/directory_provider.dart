
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';


final directoryProvider = StateNotifierProvider<DirectoryStateNotifier, List<String>>((ref) {
  return DirectoryStateNotifier();
});

class DirectoryStateNotifier extends StateNotifier<List<String>>{

  DirectoryStateNotifier() : super([]){
    updateDirectory();
  }

  Future<void> updateDirectory() async {

    final directoryBox = Hive.box<String>('directory');


    if(state.isEmpty) {
      if(directoryBox.isEmpty) {
        state = ['root'];
        directoryBox.add(state.first);
        return;
      }

      state = directoryBox.values.toList();
    }
  }


  Future<void> addDirectory(String name) async {
    final directoryBox = Hive.box<String>('directory');

    state = [
      ...state,
      name
    ];

    directoryBox.add(name);
  }
}