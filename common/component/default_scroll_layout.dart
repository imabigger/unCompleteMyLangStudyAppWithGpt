import 'package:flutter/material.dart';

typedef TabFunc = void Function();


class DefaultScrollLayout extends StatelessWidget {
  final List<Widget> slivers;
  final TabFunc? tabFunc;

  const DefaultScrollLayout({required this.slivers, this.tabFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if(tabFunc != null) tabFunc!();
        },
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          slivers: slivers,
        ),
      ),
    );
  }
}
