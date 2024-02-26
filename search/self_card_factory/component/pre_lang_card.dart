import 'package:flutter/material.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';

class PreSentenceCard extends StatefulWidget {
  final String sentence;
  final GestureTapCallback? onTap;
  final bool isModifyMode;
  final ValueChanged<String>? onChanged;
  final Color? borderColor;


  const PreSentenceCard({
    required this.sentence,
    required this.onTap,
    this.isModifyMode = false,
    this.onChanged,
    this.borderColor,
    super.key,
  });

  @override
  PreSentenceCardState createState() => PreSentenceCardState();
}

class PreSentenceCardState extends State<PreSentenceCard>
    with SingleTickerProviderStateMixin {
  late TextEditingController textEditingController;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    textEditingController = TextEditingController(text: widget.sentence);
  }

  @override
  void dispose() {
    _controller.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.text = widget.sentence;
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _controller,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: widget.borderColor ?? Colors.grey, width: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: ListTile(
            onTap: widget.onTap,
            title: !widget.isModifyMode
                ? Text(
                    widget.sentence,
                    style: TextStyle(fontSize: 18.0),
                  )
                : TextField(
              autofocus: true,
                    onChanged: widget.onChanged,
                    controller: textEditingController,
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
          ),
        ),
      ),
    );
  }
}
