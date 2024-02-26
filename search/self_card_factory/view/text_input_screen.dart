import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_language_ai_flutter_project/common/component/alert_function.dart';
import 'package:study_language_ai_flutter_project/common/component/default_scroll_layout.dart';
import 'package:study_language_ai_flutter_project/common/component/drop_button.dart';
import 'package:study_language_ai_flutter_project/common/component/top_hero_layout.dart';
import 'package:study_language_ai_flutter_project/common/component/wirte_type_tile.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/provider/gpt_sentence_provider.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';
import 'package:study_language_ai_flutter_project/lang_card/provider/lang_card_provider.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/component/next_end_alert.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/component/pre_lang_card.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/model/self_input_card_info_model.dart';
import 'package:study_language_ai_flutter_project/user/provider/directory_provider.dart';
import 'package:collection/collection.dart';

enum WriteTypeOfTile {
  none,
  selfWrite,
  openFile,
  selfCard,
}

class TextInputScreen extends ConsumerStatefulWidget {
  const TextInputScreen({super.key});

  @override
  ConsumerState<TextInputScreen> createState() => _TextInputScreenState();
}

class _TextInputScreenState extends ConsumerState<TextInputScreen> {
  final List<SelfInputCardInfo> selfInputCards = [];

  WriteTypeOfTile typeOfTile = WriteTypeOfTile.none;
  String? inputString;
  String? dropDownValueDirectory;
  int? focusIndex;

  static List<WriteTypeTile> _catalog = [
    WriteTypeTile(
        icon: Icons.article_outlined, writeTypeName: '직접 쓰고 Gpt', index: 0),
    WriteTypeTile(icon: Icons.file_open, writeTypeName: '파일 열기', index: 1),
    WriteTypeTile(
        icon: Icons.add_card_outlined, writeTypeName: '직접 만들기', index: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultScrollLayout(
      slivers: [
        SliverToBoxAdapter(
          child: TopHeroLayout(
            tag: 'Self-Make-ContainerBox',
            color: GREEN_COLOR,
          ),
        ),
        const SliverPadding(padding: EdgeInsets.symmetric(vertical: 16.0)),
        _choiceTypeOfTile(),
        const SliverPadding(padding: EdgeInsets.symmetric(vertical: 16.0)),
        if (typeOfTile == WriteTypeOfTile.selfWrite)
          SelfWritingToCard(
            onChanged: (string) {
              setState(() {
                inputString = string;
              });
            },
            currentString: inputString,
            directory: dropDownValueDirectory,
          ),
        if (typeOfTile == WriteTypeOfTile.selfCard) selfMakeCard(),
        if (typeOfTile == WriteTypeOfTile.selfCard)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: GREEN_COLOR, elevation: 10.0),
                child: const Text('Make'),
                onPressed: () async {
                  alert_function(
                    onConfirmPressed: () {
                      ref
                          .read(langCardProvider(dropDownValueDirectory!)
                              .notifier)
                          .saveCards(List.generate(
                            selfInputCards.length,
                            (index) =>
                                Util.makeCardModelFromDirectoryAndSentence(
                                    dropDownValueDirectory!,
                                    selfInputCards[index].value,
                                    selfInputCards[index].lang),
                          ).toList());
                      context.pop();
                      context.pop();
                    },
                    alertMessage: '$dropDownValueDirectory 위치에 save 됩니다.',
                    validator: () {
                      if (dropDownValueDirectory == null) return false;

                      var emptyCard = selfInputCards.firstWhereOrNull((model) =>
                          model.value == '' || model.value.trim().isEmpty);
                      if (emptyCard != null) {
                        return false;
                      }
                      return true;
                    },
                    validatorFalseMessage:
                        'Not Selected Space Or There is empty card!',
                    context: context,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  SliverList selfMakeCard() {
    if (selfInputCards.isEmpty) {
      var gKey = GlobalKey<PreSentenceCardState>();

      selfInputCards
          .add(SelfInputCardInfo(key: gKey, value: "Enter New Entry"));
    }

    return SliverList.builder(
      itemCount: selfInputCards.length * 2,
      itemBuilder: (context, index) {
        return index.isEven
            ? PreSentenceCard(
                key: selfInputCards[index ~/ 2].key,
                sentence: selfInputCards[index ~/ 2].value,
                onTap: () {
                  setState(() {
                    focusIndex = index ~/ 2;
                  });
                },
                onChanged: (String value) {
                  selfInputCards[index ~/ 2].value = value;
                },
                isModifyMode: focusIndex == index ~/ 2,
          borderColor: GREEN_COLOR.withOpacity(0.2),
              )
            : focusIndex == index ~/ 2
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.cut),
                          onPressed: () {
                            if (focusIndex != null) {
                              GlobalKey<PreSentenceCardState> focusKey =
                                  selfInputCards[focusIndex!].key;

                              TextEditingController? focusController =
                                  focusKey.currentState?.textEditingController;
                              if (focusController != null) {
                                int cursorPos =
                                    focusController.selection.baseOffset;

                                if (cursorPos != -1) {
                                  // 커서 왼쪽의 모든 텍스트를 가져옵니다.
                                  String leftText = focusController.text
                                      .substring(0, cursorPos);

                                  // 커서 오른쪽의 모든 텍스트를 가져옵니다.
                                  String rightText =
                                      cursorPos < focusController.text.length
                                          ? focusController.text
                                              .substring(cursorPos)
                                          : "";

                                  selfInputCards[focusIndex!].value = leftText;
                                  selfInputCards.insert(
                                      focusIndex! + 1,
                                      SelfInputCardInfo(
                                          key:
                                              GlobalKey<PreSentenceCardState>(),
                                          value: rightText));

                                  setState(() {});
                                }
                              }
                            }
                          },
                          splashRadius: 16.0,
                        ),
                        IconButton(
                          icon: Icon(Icons.add_outlined),
                          onPressed: () {},
                          splashRadius: 16.0,
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_outlined),
                          onPressed: () {},
                          splashRadius: 16.0,
                        ),
                      ],
                    ),
                  )
                : SizedBox(height: 16);
      },
    );
  }

  Future<void> addSpace() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Space Name'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '공간의 이름을 입력',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // Handle your text here
                final inputText = controller.text;
                ref.read(directoryProvider.notifier).addDirectory(inputText);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  SliverToBoxAdapter _choiceTypeOfTile() {
    final directorys = ref.watch(directoryProvider);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: GREEN_COLOR.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropDownButtonCustom<String>(
                  onChanged: (String? value) {
                    if (value == 'Add Space') {
                      addSpace();
                      return;
                    }

                    setState(() {
                      dropDownValueDirectory = value;
                    });
                  },
                  value: dropDownValueDirectory,
                  hintText: "Card가 저장될 공간 선택",
                  items: directorys + ['Add Space'],
                  valueToString: (String val) {
                    return val;
                  },
                ),
              ),
              ..._catalog
                  .map(
                    (e) => InkWell(
                  onTap: () {
                    focusIndex = null;
                    if (e.index == 0) {
                      setState(() {
                        typeOfTile = WriteTypeOfTile.selfWrite;
                      });
                    } else if (e.index == 2) {
                      setState(() {
                        typeOfTile = WriteTypeOfTile.selfCard;
                      });
                    } else {
                      setState(() {
                        typeOfTile = WriteTypeOfTile.openFile;
                      });
                    }
                  },
                  child: ListTile(
                    leading: Icon(
                      e.icon,
                    ),
                    title: Text(e.writeTypeName),
                  ),
                ),
              )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class SelfWritingToCard extends ConsumerWidget {
  final ValueChanged<String>? onChanged;
  final String? currentString;
  final String? directory;

  const SelfWritingToCard(
      {required this.onChanged,
      required this.currentString,
      required this.directory,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: EdgeInsets.symmetric( horizontal: 8.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: GREEN_COLOR.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0,),
              Text(
                'Self Writing Mode',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  maxLines: null,
                  minLines: 10,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                    hintText: '여기에 입력하여 CARD로 변환, 1문장 이상 해야 정상작동',
                    border: OutlineInputBorder(borderSide: BorderSide(color: GREEN_COLOR.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: GREEN_COLOR),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: GREEN_COLOR.withOpacity(0.5),width: 0.7),
                    ),
                  ),
                ),

              ),
              NextEndAlert(
                onConfirmPressed: () {
                  Navigator.of(context).pop();
                  ref
                      .read(gptSentenceProvider.notifier)
                      .rawStringToJsonSentenceMaker(currentString!);
                  context.go('/selfmake/selfcard/$directory');
                },
                alertMessage:
                    '이 글로 문장이 자동 생성됩니다. \n(!!! 저작권에 저촉, 부적절한 내용 등은 Error가 납니다.)',
                validator: () {
                  if (currentString == null || directory == null) {
                    return false;
                  }
                  return currentString!.trim().isNotEmpty;
                },
                validatorFalseMessage:
                    directory == null ? '저장될 공간을 선택해야 합니다.' : '입력 Text가 필요합니다.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
