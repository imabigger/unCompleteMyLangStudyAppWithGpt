import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/model/pagination_model.dart';
import 'package:study_language_ai_flutter_project/common/provider/data_base_provider.dart';
import 'package:study_language_ai_flutter_project/common/utill/paginate_utill.dart';
import 'package:study_language_ai_flutter_project/search/component/pagination_scroll_view.dart';
import 'package:study_language_ai_flutter_project/search/hot/provider/pagination_hot_provider.dart';
import 'package:study_language_ai_flutter_project/search/provider/pagination_card_provider.dart';
import 'package:study_language_ai_flutter_project/search/serachfield/custom_text_from_field.dart';
import 'package:go_router/go_router.dart';
import 'package:study_language_ai_flutter_project/search/upload/model/upload_model.dart';
import 'package:study_language_ai_flutter_project/user/provider/upload_star_card_provider.dart';


enum BoxSize {
  big,
  small,
}


class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final starChecked = ref.watch(starProvider);
    // final db = ref.read(fireStoreProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: PaginationScrollView(
        renderSliverWidgets: [
          _Top(),
          _Middle(),
        ],
        provider: paginationCardProvider,
        itemBuilder: <UploadModel>(context, index, model) {


          // final docRef = db
          //     .collection('search')
          //     .doc('hot')
          //     .collection(HotDocName.searched_count.name)
          //     .doc(model.docId);
          //
          // docRef.set({
          //   'count': FieldValue.increment(1),
          // }, SetOptions(merge: true));

          bool isStar = starChecked.contains(model.docId);

          return ListTile(
            titleAlignment: ListTileTitleAlignment.titleHeight,
            isThreeLine: true,
            onTap: () {
              print("ListTile tapped!");
            },
            tileColor: Colors.white, // 배경색
            leading: GestureDetector(
              onTap: () {
                if(isStar){
                  ref.read(starProvider.notifier).deleteStar(model.docId);
                } else{
                  ref.read(starProvider.notifier).addStar(model.docId);
                }
              },
              child: Icon(
                isStar ? Icons.star : Icons.star_border, // 채운 별 또는 빈 별
                color: Colors.blue,
              ),
            ),
            title: Text(
              model.title.toString().trim() == '' ? 'No Title' : model.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black, // 검은색 제목
              ),
            ),
            subtitle: Text(
              model.subtext.toString().trim() == '' ? 'No Title' : model.subtext.toString().trim(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.blueGrey, // 부제목의 글자색
              ),
            ),
            trailing: Icon(Icons.arrow_forward, color: Colors.blue),
          );
        },
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      stretch: true,
      floating: true,
      titleSpacing: 16.0,
      toolbarHeight: 72.0,
      elevation: 1,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Card',
            style: TextStyle(color: Colors.black),
            // textAlign: TextAlign.left,
          ),
          SizedBox(height: 4.0),
          SearchTextFrom(),
        ],
      ),
      expandedHeight: 80,
    );
  }
}

class _Middle extends StatelessWidget {
  const _Middle({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: Container(
        height: 500,
        width: width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'Hot-Card',
                child: _renderBox(
                  boxWidth: width * 3 / 7,
                  boxSize: BoxSize.big,
                  boxText: 'Most Popular',
                  color: YELLOW_COLOR,
                  onTap: () {
                    context.go('/hot');
                  },
                ),
              ),
              Column(
                children: [
                  Hero(
                    tag: 'Upload-Card',
                    child: _renderBox(
                      boxWidth: width * 3 / 7,
                      boxSize: BoxSize.small,
                      boxText: 'Upload',
                      color: BLUE_COLOR,
                      onTap: () {
                        context.go('/upload');
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  Hero(
                    tag: 'Self-Make-ContainerBox',
                    child: _renderBox(
                        boxWidth: width * 3 / 7,
                        boxSize: BoxSize.small,
                        boxText: 'Self Make',
                        color: GREEN_COLOR,
                        onTap: () {
                          context.go('/selfmake');
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Material _renderBox({
    required double boxWidth,
    required BoxSize boxSize,
    required String boxText,
    required Color color,
    required GestureTapCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: boxSize == BoxSize.big ? 400 : 180,
          width: boxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: color,
          ),
          child: Align(
            alignment: Alignment(0.7, 0.8),
            child: Text(boxText),
          ),
        ),
      ),
    );
  }
}
