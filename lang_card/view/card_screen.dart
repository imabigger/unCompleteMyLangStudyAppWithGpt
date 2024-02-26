import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/component/drop_button.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/lang_card/component/card_render.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';
import 'package:study_language_ai_flutter_project/lang_card/provider/lang_card_provider.dart';
import 'package:study_language_ai_flutter_project/sound/provider/sound_option_provider.dart';
import 'package:study_language_ai_flutter_project/user/provider/directory_provider.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';

class CardScreen extends ConsumerStatefulWidget {
  const CardScreen({super.key});

  @override
  ConsumerState<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends ConsumerState<CardScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final box = Hive.box<String>('lowSecurityRequired');

  String? directory;
  Lang? toLang;
  int? focusIndex;

  @override
  void initState() {
    // TODO: implement initState
    toLang = Util.changeStringToLang(box.get(tolang_save_key, defaultValue: null));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    EasyDebounce.cancelAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (directory == null)
      ref
          .read(langCardProvider(initial_Directory).notifier)
          .updateCardFromBox();

    final cards = ref.watch<List<CardModel>>(
        langCardProvider(directory ?? initial_Directory));

    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              color: Colors.green.withOpacity(1),
              width: 16.0,
              height: 40.0,
            ),
          ),
          Positioned(
            top: 40,
            child: Container(
              color: Colors.redAccent.withOpacity(1),
              width: 16.0,
              height: 40.0,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                focusIndex = null;
              });
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _toLangButton(),
                ),
                _selectDirectoryButton(),
                SizedBox(height: 10.0),
                Expanded(
                  child: ReorderableListView.builder(
                    onReorder: (oldIndex, newIndex) async {
                      if(directory == null){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Card 공간이 선택되어 있을때만 재배열 할 수 있습니다.'),
                        ));

                        return;
                      }
                      final current_directory= directory!;
                      final beCard = cards[oldIndex];
                      cards.removeAt(oldIndex);

                      if(newIndex > oldIndex) newIndex--;

                      cards.insert(newIndex, beCard);

                      EasyDebounce.debounce(
                          'rearrange-Card',
                          Duration(seconds: 2),
                          () => ref.read(langCardProvider(current_directory).notifier).saveCards([])
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CardRenderWidget(
                        key: Key(cards[index].cardUniqueId),
                        baseUserLang:
                            Util.changeStringToLang(box.get(base_lang_key)) ?? Lang.English,
                        card: cards[index],
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        toLang: toLang,
                        isFocused: focusIndex == index ? true : false,
                        tabBox: () {
                          setState(() {
                            if (focusIndex == null || focusIndex != index) {
                              focusIndex = index;
                            } else {
                              focusIndex = null;
                            }
                          });
                        },
                      );
                    },
                    itemCount: cards.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toLangButton() {
    return DropdownButtonHideUnderline(
      child: DropDownButtonSearchCustom<Lang>(
        value: toLang,
        hintText: 'Study Language 선택',
        onChanged: (Lang? lang) {
          if(toLang != lang){
            ref.read(ttsOptionProvider.notifier).deleteTTSOption();
          }
          setState(() {
            toLang = lang;
          });
          box.put(tolang_save_key, toLang!.name);
        },
        items: Lang.values,
        valueToString: (Lang val) {
          return val.name;
        },
        textEditingController: _textEditingController,
        buttonSize: MediaQuery.of(context).size.width,
        dropSize: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _selectDirectoryButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropDownButtonCustom<String>(
        value: directory,
        onChanged: (String? value) {
          setState(() {
            directory = value;
          });
        },
        hintText: 'CARD 공간 선택',
        items: ref.watch(directoryProvider),
        valueToString: (String val) {
          return val;
        },
      ),
    );
  }

}
