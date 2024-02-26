import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/component/default_scroll_layout.dart';
import 'package:study_language_ai_flutter_project/common/component/drop_button.dart';
import 'package:study_language_ai_flutter_project/common/component/top_hero_layout.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/common/provider/data_base_provider.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';
import 'package:study_language_ai_flutter_project/lang_card/component/card_render.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';
import 'package:study_language_ai_flutter_project/lang_card/provider/lang_card_provider.dart';
import 'package:study_language_ai_flutter_project/search/component/card_bottom_lang_list.dart';
import 'package:study_language_ai_flutter_project/search/upload/model/upload_model.dart';
import 'package:study_language_ai_flutter_project/user/auth/auth.dart';
import 'package:study_language_ai_flutter_project/user/provider/directory_provider.dart';
import 'package:uuid/uuid.dart';

class UploadSelectionScreen extends ConsumerStatefulWidget {
  const UploadSelectionScreen({super.key});

  @override
  ConsumerState<UploadSelectionScreen> createState() =>
      _UploadSelectionScreenState();
}

class _UploadSelectionScreenState extends ConsumerState<UploadSelectionScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  final box = Hive.box<String>('lowSecurityRequired');

  String? directory;

  List<CardModel> temp = [];

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    bodyController.dispose();
    temp.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cards = ref.read<List<CardModel>>(
        langCardProvider(directory ?? initial_Directory));

    return Scaffold(
      body: DefaultScrollLayout(
        slivers: [
          const SliverToBoxAdapter(
            child: TopHeroLayout(
              tag: 'Upload-Card',
              color: BLUE_COLOR,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 24.0)),
          _infoLay(),
          const SliverPadding(padding: EdgeInsets.only(top: 32.0)),
          _mid(),
          const SliverPadding(padding: EdgeInsets.only(top: 24.0)),
          _selectedCardView(),
          const SliverPadding(padding: EdgeInsets.only(top: 24.0)),
          _choiceCard(cards),
          const SliverPadding(padding: EdgeInsets.only(top: 16.0)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: BLUE_COLOR, elevation: 10.0),
                child: const Text('Upload'),
                onPressed: () async {
                  try {
                    Util.showLoadingDialogUseTryCatch(context);

                    final user = Auth().currentUser;

                    if (user == null) {
                      throw '로그인이 필요합니다.';
                    } else if (titleController.text.trim().isEmpty ||
                        bodyController.text.trim().isEmpty) {
                      throw '빈 칸으로는 업로드 할 수 없습니다.';
                    } else if(temp.isEmpty){
                      throw 'card가 한개도 포함되어 있지 않습니다.';
                    }

                    final u4 = const Uuid().v4();

                    final uploadModel = UploadModel(
                        cards: temp,
                        title: titleController.text,
                        subtext: bodyController.text,
                        uid: user.uid, docId: u4);

                    final db = ref.read(fireStoreProvider);
                    final docRef = db
                        .collection('search')
                        .doc('uploaded')
                        .collection('userUpload')
                        .doc(u4);

                    await docRef.set(uploadModel.toJson()).then((value) {
                      print('[upload] firestore에 내용이 upload 됨.');
                      context.pop();
                      context.pop(); //업로드 페이지로 이동 나중에.
                    });

                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));

                    context.pop();

                    await Future.delayed(Duration(seconds: 1)).then((value) =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar());

                    print(e);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter _infoLay() {
    return const SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_fix_high_outlined),
              SizedBox(
                width: 16.0,
              ),
              Text(
                'Upload Your Card',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Divider(
            height: 8.0,
            thickness: 2.0,
            indent: 64.0,
            endIndent: 64.0,
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _mid() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: BLUE_COLOR.withOpacity(0.2)),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: '제목을 입력하세요',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              Divider(
                color: BLUE_COLOR.withOpacity(0.2),
                height: 4.0,
                thickness: 0.5,
                indent: 8.0,
                endIndent: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  minLines: 10,
                  controller: bodyController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: '본문을 입력하세요',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _choiceCard(List<CardModel> cards) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: BLUE_COLOR.withOpacity(0.2)),
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
              ),
              ...cards.where((e) => !temp.contains(e)).map(
                    (e) => CardRenderWidget(
                      key: Key(e.cardUniqueId),
                      baseUserLang:
                          Util.changeStringToLang(box.get(base_lang_key)) ??
                              Lang.English,
                      card: e,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      toLang: e.baseLang,
                      isFocused: false,
                      tabBox: () {
                        setState(() {
                          temp.add(e);
                        });
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _selectedCardView() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: BLUE_COLOR.withOpacity(0.2)),
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
              const ListTile(
                title: Text("Selected Card"),
              ),
              ...temp.map(
                (e) => Hero(
                  tag: e.cardUniqueId,
                  child: Column(
                    children: [
                      CardRenderWidget(
                        key: Key(e.cardUniqueId),
                        baseUserLang:
                            Util.changeStringToLang(box.get(base_lang_key)) ??
                                Lang.English,
                        card: e,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        toLang: e.baseLang,
                        isFocused: false,
                        tabBox: () {
                          setState(() {
                            temp.remove(e);
                          });
                        },
                        isSearchView: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CardBottomLangList(
                              card: e,
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
