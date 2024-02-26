import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:study_language_ai_flutter_project/common/component/default_scroll_layout.dart';
import 'package:study_language_ai_flutter_project/common/component/top_hero_layout.dart';

class LoadingCard extends StatelessWidget {
  final Color? topLayoutColor;
  final String? topLayoutTag;

  const LoadingCard({this.topLayoutColor, this.topLayoutTag, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScrollLayout(
      slivers: [
        if (topLayoutTag != null && topLayoutColor != null)
          SliverToBoxAdapter(
            child: TopHeroLayout(
              tag: topLayoutTag!,
              color: topLayoutColor!,
            ),
          ),
        SliverPadding(
          padding: EdgeInsets.only(
            top: 20.0,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: List.generate(15, (index) {
                return Column(
                  children: [
                    SizedBox(height: 16.0,),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        width: double.infinity,
                        minHeight: MediaQuery.of(context).size.height / 5,
                        maxHeight: MediaQuery.of(context).size.height / 4,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
