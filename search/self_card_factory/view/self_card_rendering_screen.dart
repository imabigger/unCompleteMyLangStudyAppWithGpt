import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_language_ai_flutter_project/common/component/default_scroll_layout.dart';
import 'package:study_language_ai_flutter_project/common/component/top_hero_layout.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/provider/gpt_sentence_provider.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';
import 'package:study_language_ai_flutter_project/common/view/loading_card_skeleton.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';
import 'package:study_language_ai_flutter_project/lang_card/provider/lang_card_provider.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/component/next_end_alert.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/component/pre_lang_card.dart';
import 'package:collection/collection.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/model/sentence.dart';

class SelfCardRenderingScreen extends ConsumerStatefulWidget {
  final String directory;

  const SelfCardRenderingScreen({required this.directory, super.key});

  @override
  ConsumerState<SelfCardRenderingScreen> createState() =>
      _SelfCardRenderingScreenState();
}

class _SelfCardRenderingScreenState
    extends ConsumerState<SelfCardRenderingScreen> {
  int? focusIndex;
  int? focusAndModifyIndex;
  int createCount = 0;

  @override
  Widget build(BuildContext context) {
    final SentenceModelBase sentencesModel = ref.watch(gptSentenceProvider);

    if (sentencesModel is SentenceModelLoading) {
      return LoadingCard(
        topLayoutColor: GREEN_COLOR,
        topLayoutTag: 'Self-Make-ContainerBox',
      );
    }

    final sentences = (sentencesModel as SentenceModel).sentence;
    final sentenceLangList = sentencesModel.lang;

    return DefaultScrollLayout(
      tabFunc: () {
        setState(() {
          focusIndex = null;
          focusAndModifyIndex = null;
        });
      },
      slivers: [
        _Top(),
        SliverPadding(padding: EdgeInsets.symmetric(vertical: 10.0)),
        _infoLay(),
        SliverPadding(padding: EdgeInsets.symmetric(vertical: 4.0)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return index.isEven
                  ? PreSentenceCard(
                      key: ValueKey(sentences[index ~/ 2]),
                      sentence: sentences[index ~/ 2],
                      onChanged: (string) {
                        sentences[index ~/ 2] = string;
                      },
                      onTap: () {
                        setState(() {
                          focusIndex = index ~/ 2;
                          focusAndModifyIndex = null;
                        });
                      },
                      isModifyMode: focusAndModifyIndex == index ~/ 2,
                    )
                  : focusIndex != index ~/ 2
                      ? SizedBox(height: 16.0)
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_outlined),
                                onPressed: () {
                                  setState(() {
                                    createCount++;
                                    sentences.insert(focusIndex! + 1,
                                        'Enter new sentence $createCount');
                                    focusIndex = null;
                                  });
                                },
                                splashRadius: 16.0,
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_outlined),
                                onPressed: () {
                                  setState(() {
                                    sentences.removeAt(focusIndex!);
                                    focusIndex = null;
                                  });
                                },
                                splashRadius: 16.0,
                              ),
                              IconButton(
                                icon: Icon(Icons.mode_edit_outlined),
                                onPressed: () {
                                  setState(() {
                                    focusAndModifyIndex = focusIndex;
                                  });
                                },
                                splashRadius: 16.0,
                              ),
                            ],
                          ),
                        );
            },
            childCount: focusIndex != sentences.length - 1
                ? max(0, sentences.length * 2 - 1)
                : sentences.length * 2,
          ),
        ),
        SliverToBoxAdapter(
          child: NextEndAlert(
            onConfirmPressed: () {
              ref
                  .read(langCardProvider(widget.directory).notifier)
                  .saveCards(List.generate(
                    sentences.length,
                    (index) => Util.makeCardModelFromDirectoryAndSentence(
                        widget.directory, sentences[index], sentenceLangList[index]),
                  ).toList());
              ref.read(gptSentenceProvider.notifier).stateClear();
              context.pop();
              context.pop();
              context.pop();
            },
            alertMessage: '${widget.directory}에 만들어진 CARD들이 저장됩니다.',
            validator: () {
              String? emptyCard = sentences.firstWhereOrNull(
                  (sentence) => sentence == '' || sentence.trim().isEmpty);
              if (emptyCard == null) return true;
              return false;
            },
            validatorFalseMessage: '빈 카드를 지우거나 채워주십시오.',
          ),
        ),
      ],
    );
  }

  SliverToBoxAdapter _infoLay() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_fix_high_outlined),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  'Auto Divide Sentence',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          Divider(
            height: 8.0,
            thickness: 2.0,
            indent: 32.0,
            endIndent: 32.0,
          ),
          ListTile(
            title: Text(
              'Last Modify',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _Top() {
    return SliverToBoxAdapter(
      child: TopHeroLayout(
        tag: 'Self-Make-ContainerBox',
        color: GREEN_COLOR,
      ),
    );
  }
}
