import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_language_ai_flutter_project/common/model/pagination_model.dart';
import 'package:study_language_ai_flutter_project/common/provider/pagination_provider.dart';
import 'package:study_language_ai_flutter_project/common/utill/paginate_utill.dart';
import 'package:study_language_ai_flutter_project/search/provider/pagination_card_provider.dart';

typedef PaginationWidgetBuilder<T> = Widget Function(
    BuildContext context, int index, T model);

class PaginationScrollView<T> extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  final List<Widget> renderSliverWidgets;

  const PaginationScrollView({
    required this.provider,
    required this.itemBuilder,
    required this.renderSliverWidgets,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PaginationScrollView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T> extends ConsumerState<PaginationScrollView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(listener);
  }

  void listener() {
    EasyThrottle.throttle('pagination', Duration(seconds: 2), () {
      PaginationUtils.paginate_scroll(
        controller: controller,
        provider: ref.read(widget.provider.notifier),
      );
    });
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

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
                  ref.read(widget.provider.notifier).paginate(
                        forceRefetch: true,
                      );
                },
                child: Text('다시 시도')),
          ]);
    }

    final cp = state as CursorPagination<T>;

    return RefreshIndicator(
      onRefresh: (){
        return ref.read(widget.provider.notifier).paginate(forceRefetch: true);
      },
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: controller,
        slivers: [
          ...widget.renderSliverWidgets,
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == cp.data.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Center(
                      child: state is CursorPaginationFetching
                          ? CircularProgressIndicator()
                          : Text('마지막 데이터'),
                    ),
                  );
                }

                final pItem = cp.data[index];
                return widget.itemBuilder(context, index, pItem);
              },
              childCount: cp.data.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}
