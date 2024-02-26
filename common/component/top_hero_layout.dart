
import 'package:flutter/material.dart';

class TopHeroLayout extends StatelessWidget {
  final String tag;
  final Color color;


  const TopHeroLayout({
    required this.tag,
    required this.color,
    super.key,});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        width: double.infinity,
        height: 16.0,
        color: color,
      ),
    );
  }
}
