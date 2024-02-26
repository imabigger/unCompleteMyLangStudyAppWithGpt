import 'package:json_annotation/json_annotation.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

class CursorPaginationLoading extends CursorPaginationBase {}


class CursorPagination<T> extends CursorPaginationBase {
  final List<T> data;

  CursorPagination({
    required this.data,
  });

  CursorPagination copyWith({
    List<T>? data,
  }) {
    return CursorPagination<T>(data: data ?? this.data);
  }
}



class CursorPaginationFetching<T> extends CursorPagination<T> {
  CursorPaginationFetching({required super.data});
}