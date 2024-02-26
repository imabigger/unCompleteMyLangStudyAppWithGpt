import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/component/default_scroll_layout.dart';
import 'package:study_language_ai_flutter_project/common/component/drop_button.dart';
import 'package:study_language_ai_flutter_project/common/component/top_hero_layout.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/search/component/pagination_button_view.dart';
import 'package:study_language_ai_flutter_project/search/hot/provider/pagination_hot_provider.dart';
import 'package:study_language_ai_flutter_project/search/upload/model/upload_model.dart';

import '../../../user/provider/upload_star_card_provider.dart';


class HotScreen extends ConsumerWidget {
  const HotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      body: DefaultScrollLayout(
        slivers: [
          const SliverToBoxAdapter(
            child: TopHeroLayout(
              tag: 'Hot-Card',
              color: YELLOW_COLOR,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 24.0)),
          _infoLay(),
          const SliverPadding(padding: EdgeInsets.only(top: 24.0)),
          _hotCardsView(hotName: 'Most download', ref: ref, hotDocName: HotDocName.download_count),
          const SliverPadding(padding: EdgeInsets.only(top: 24.0)),
          _hotCardsView(hotName: 'Most seen', ref: ref, hotDocName: HotDocName.searched_count),
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
              Icon(Icons.local_fire_department_outlined),
              SizedBox(
                width: 16.0,
              ),
              Text(
                'Hot Cards',
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

  SliverToBoxAdapter _hotCardsView({
    required WidgetRef ref,
    required String hotName,
    required HotDocName hotDocName,
  }) {
    final starChecked = ref.watch(starProvider);

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
              ListTile(
                title: Text(hotName),
              ),
              PaginationFamilyButtonView(
                provider: paginationHotProvider,
                hotDocName: hotDocName,
                itemBuilder: <UploadModel>(context, index, model) {
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
                        color: Colors.yellow.shade500,
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
            ],
          ),
        ),
      ),
    );
  }
}
