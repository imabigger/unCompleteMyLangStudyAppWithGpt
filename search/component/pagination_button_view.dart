import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_language_ai_flutter_project/common/model/pagination_model.dart';
import 'package:study_language_ai_flutter_project/common/provider/pagination_provider.dart';
import 'package:study_language_ai_flutter_project/common/utill/paginate_utill.dart';
import 'package:study_language_ai_flutter_project/search/hot/provider/pagination_hot_provider.dart';
import 'package:study_language_ai_flutter_project/search/provider/pagination_card_provider.dart';

typedef PaginationWidgetBuilder<T> = Widget Function(
    BuildContext context, int index, T model);

class PaginationFamilyButtonView<T> extends ConsumerStatefulWidget {
  final StateNotifierProviderFamily<PaginationProvider, CursorPaginationBase, HotDocName>
      provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  final HotDocName hotDocName;

  const PaginationFamilyButtonView({
    required this.provider,
    required this.itemBuilder,
    required this.hotDocName,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PaginationFamilyButtonView> createState() =>
      _PaginationListButtonViewState<T>();
}

class _PaginationListButtonViewState<T>
    extends ConsumerState<PaginationFamilyButtonView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider(widget.hotDocName));

    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is CursorPaginationError) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.message,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () {
                  ref.read(widget.provider(widget.hotDocName).notifier).paginate(
                        forceRefetch: true,
                      );
                },
                child: Text('다시 시도')),
          ]);
    }

    final cp = state as CursorPagination<T>;

    return Column(
      children: [
        ...cp.data.asMap().entries.map(
              (e) => widget.itemBuilder(context, e.key, e.value),
            ).toList(),
        TextButton(onPressed: (){
          PaginationUtils.paginate_button(fetchCount: 10, provider: ref.read(widget.provider(widget.hotDocName).notifier));
        }, child: Row(children: [FittedBox(child: Icon(Icons.add)), Text('More Render')],))
      ],
    );
  }
}
