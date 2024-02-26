import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/component/alert_function.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';
import 'package:study_language_ai_flutter_project/lang_card/component/card_unit_explain_render.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';
import 'package:collection/collection.dart';
import 'package:study_language_ai_flutter_project/lang_card/provider/lang_card_provider.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/component/next_end_alert.dart';
import 'package:study_language_ai_flutter_project/sound/card/card_speech.dart';
import 'package:study_language_ai_flutter_project/sound/provider/sound_option_provider.dart';

class _translateInfo {
  String currentLangString;
  Lang currentLang;
  Lang toLang;

  _translateInfo({
    this.toLang = Lang.English,
    this.currentLang = Lang.English,
    required this.currentLangString,
  });
}

class CardRenderWidget extends ConsumerStatefulWidget {
  final CardModel card;
  final EdgeInsetsGeometry padding;
  final Lang? toLang;
  final void Function() tabBox;
  final bool isFocused;
  final Lang baseUserLang;
  final bool isSearchView;

  const CardRenderWidget({
    required this.toLang,
    required this.card,
    required this.padding,
    required this.tabBox,
    required this.baseUserLang,
    this.isFocused = false,
    this.isSearchView = false,
    super.key,
  });

  @override
  ConsumerState<CardRenderWidget> createState() => _CardRenderWidgetState();
}

class _CardRenderWidgetState extends ConsumerState<CardRenderWidget> {
  bool isTextSelected = false;
  bool _isDetailShow = false;

  @override
  void dispose() {
    // TODO: implement dispose
    EasyThrottle.cancelAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LangStorageModel? transedLangStorage = widget.card.langStorage
        .firstWhereOrNull((storage) => storage.language == widget.toLang);
    final LangStorageModel? baseStorage = widget.card.langStorage
        .firstWhereOrNull((element) => element.language == widget.baseUserLang);

    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          Ink(
            height: widget.isFocused || widget.isSearchView
                ? MediaQuery.of(context).size.height * 2 / 15
                : MediaQuery.of(context).size.height * 2 / 15 + 10,
            width: double.infinity,
            child: InkWell(
              onTap: () {
                widget.tabBox();
              },
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ColoredBox(
                      color: Colors.blueGrey.withOpacity(0.4),
                      child: Center(),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          isTextSelected = !isTextSelected;
                        });
                        if (isTextSelected) {
                          // 선택되었다는 것은, uSer base 언어를 출력한다는 뜻
                          if (baseStorage == null) {
                            //throttle 처리 필요.
                            EasyThrottle.throttle(
                                'trans-snak-button-${widget.card.cardUniqueId}',
                                Duration(seconds: 5),
                                () => transSnackBar(_translateInfo(
                                      currentLangString: widget.card.baseString,
                                      currentLang: widget.card.baseLang,
                                      toLang: widget.baseUserLang,
                                    )),
                                onAfter:
                                    () {} // <-- Optional callback, called after the duration has passed
                                );
                          }
                        } else {
                          if (widget.toLang != null &&
                              widget.toLang != Lang.Unknown &&
                              transedLangStorage == null) {
                            EasyThrottle.throttle(
                                'trans-snak-button-${widget.card.cardUniqueId}',
                                Duration(seconds: 5),
                                () => transSnackBar(_translateInfo(
                                      currentLangString: widget.card.baseString,
                                      currentLang: widget.card.baseLang,
                                      toLang: widget.toLang!,
                                    )),
                                onAfter:
                                    () {} // <-- Optional callback, called after the duration has passed
                                );
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.blueGrey.withOpacity(0.4),
                                width: 1.0),
                            right: BorderSide(
                                color: Colors.blueGrey.withOpacity(0.4),
                                width: 1.0),
                            left: BorderSide(
                                color: Colors.blueGrey.withOpacity(0.4),
                                width: 1.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            whatToShowCardText(transedLangStorage, baseStorage,
                                isTextSelected),
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!widget.isFocused && !widget.isSearchView)
                    SizedBox(
                      height: 10.0,
                    )
                ],
              ),
            ),
          ),
          if (widget.isFocused)
            _CardBottomRender(
              card: widget.card,
              tabBox: widget.tabBox,
              transedLangStorage: transedLangStorage,
              toLang: widget.toLang,
              baseUserLang: widget.baseUserLang,
              onDetailPressed: () {
                setState(() {
                  _isDetailShow = !_isDetailShow;
                });
              },
              isShow: _isDetailShow,
              baseStorage: baseStorage,
            ),
        ],
      ),
    );
  }

  String whatToShowCardText(LangStorageModel? transedLangStorage,
      LangStorageModel? baseStorage, bool isTextSelected) {
    if (isTextSelected) {
      //선택이 되어있다면 선택한 사용자의 기본 언어로 출력

      if (baseStorage == null) {
        return '선택한 기본언어로 번역을 해주세요.';
      }

      return baseStorage.transString;
    }

    if (widget.toLang == null) {
      return widget.card.baseString;
    }
    if (transedLangStorage == null) return '해당 언어로 번역을 해주세요.';

    return transedLangStorage.transString;
  }

  void transSnackBar(_translateInfo translateInfo) {
    String currentLangString = translateInfo.currentLangString;
    Lang currentLang = translateInfo.currentLang;
    Lang toLang = translateInfo.toLang;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$currentLang 에서 $toLang 으로 번역합니다.'),
      action: SnackBarAction(
        label: 'Click',
        onPressed: () async {
          await ref
              .read(langCardProvider(widget.card.cardDirectory).notifier)
              .translateCardLangToLang(
                currentLangString: currentLangString,
                currentLang: currentLang,
                toLang: toLang,
                card: widget.card,
              );
          setState(() {});
        },
      ),
    ));
  }
}

class _CardBottomRender extends ConsumerWidget {
  final CardModel card;
  final LangStorageModel? transedLangStorage;
  final void Function() tabBox;
  final Lang? toLang;
  final Lang baseUserLang;
  final VoidCallback? onDetailPressed;
  final bool isShow;
  final LangStorageModel? baseStorage;

  _CardBottomRender(
      {required this.card,
      required this.tabBox,
      required this.transedLangStorage,
      required this.toLang,
      required this.baseUserLang,
      required this.onDetailPressed,
      required this.baseStorage,
      this.isShow = false,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (isShow && transedLangStorage != null)
          CardUnitAndExplain(cardDetail: transedLangStorage!),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              tooltip: '이 카드를 영구히 삭제합니다.',
              icon: Icon(Icons.delete_forever_outlined),
              onPressed: () {
                alert_function(
                  onConfirmPressed: () async{
                    ref
                        .read(langCardProvider(card.cardDirectory).notifier)
                        .deleteCard(card);
                    final audioFile = await findAudio(
                        card, transedLangStorage!, card.cardDirectory);
                    if(audioFile != null) {
                      deleteAudioFile(audioFile);
                    }
                    tabBox();
                    context.pop();
                  },
                  alertMessage: '정말로 삭제 하시겠습니까?',
                  validator: () {
                    return true;
                  },
                  validatorFalseMessage: '',
                  context: context,
                );
              },
              splashRadius: 16.0,
            ),
            if (transedLangStorage == null ||
                transedLangStorage!.detailCards.isEmpty)
              IconButton(
                tooltip: 'Token을 사용하여 선택한 언어로 자세한 정보를 덧 붙입니다.',
                icon: Icon(Icons.mode_edit_outlined),
                onPressed: () {
                  String errorMessage = '';
                  if (toLang == null) {
                    errorMessage = '목표 언어가 설정되어있지 않습니다.';
                  }
                  if (transedLangStorage == null) {
                    errorMessage = '먼저 목표언어로 번역되어 있어야 합니다.';
                  }
                  if (baseStorage == null) {
                    errorMessage = '먼저 기본언어로 번역되어 있어야 합니다.';
                  }

                  alert_function(
                    onConfirmPressed: () async {
                      context.pop();
                      await ref
                          .read(langCardProvider(card.cardDirectory).notifier)
                          .addCardDetailWordOrPhrase(
                            userBaseLang: baseUserLang,
                            currentLang: toLang!,
                            currentLangString: transedLangStorage!.transString,
                            card: card,
                          );
                      tabBox();
                    },
                    alertMessage: '카드에 세부 정보를 추가합니다.',
                    validator: () {
                      if (errorMessage.trim().isNotEmpty) return false;
                      return true;
                    },
                    validatorFalseMessage: errorMessage,
                    context: context,
                  );
                },
                splashRadius: 16.0,
              ),
            if (transedLangStorage != null &&
                transedLangStorage!.detailCards.isNotEmpty)
              IconButton(
                tooltip: '세부 단위로 공부하기',
                icon: Icon(Icons.article_outlined),
                onPressed: onDetailPressed,
                splashRadius: 16.0,
              ),
            IconButton(
              tooltip: '선택한 언어로 재생합니다.',
              icon: Icon(Icons.volume_up_outlined),
              onPressed: () async {

                if (transedLangStorage != null) {
                  final audioFile = await findAudio(
                      card, transedLangStorage!, card.cardDirectory);

                  if (audioFile == null) {
                    final soundOption = ref.read(ttsOptionProvider);
                    if(soundOption == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('tts 설정이 필요합니다.'),
                        ),
                      );
                      return;
                    }

                    EasyThrottle.throttle(
                        'audio-snak-button-${card.cardUniqueId}',
                        Duration(seconds: 5),
                        () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('$toLang으로 읽는 음성 파일을 만듭니다.'),
                              action: SnackBarAction(
                                label: 'Click',
                                onPressed: () async {
                                  makeCardSpeech(
                                    card: card,
                                    langStorageModel: transedLangStorage!,
                                    directory: card.cardDirectory,
                                    soundOptionModel: soundOption,
                                  );
                                },
                              ),
                            )),
                        onAfter:
                            () {} // <-- Optional callback, called after the duration has passed
                        );
                  } else {
                    playTTS(audioFile);
                  }
                }
              },
              splashRadius: 16.0,
            ),
          ],
        ),
      ],
    );
  }
}
