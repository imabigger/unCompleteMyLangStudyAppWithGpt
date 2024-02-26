
import 'package:flutter/cupertino.dart';
import 'package:study_language_ai_flutter_project/common/provider/pagination_provider.dart';
import 'package:study_language_ai_flutter_project/search/provider/pagination_card_provider.dart';

class PaginationUtils {
  static void paginate_scroll({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(
        fetchMore: true,
      );
    }
  }

  static void paginate_button({
    required int fetchCount,
    required PaginationProvider provider,
}){
    if(fetchCount > 0){
      provider.paginate(fetchCount: fetchCount, fetchMore: true);
    }
  }
}
