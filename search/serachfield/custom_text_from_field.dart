
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTextFrom extends StatelessWidget {
  const SearchTextFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      autofocus: false,
      placeholder: 'Search',
    );
  }
}
