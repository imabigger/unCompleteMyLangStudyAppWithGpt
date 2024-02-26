import 'package:flutter/material.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';

class CardUnitAndExplain extends StatefulWidget {
  final LangStorageModel cardDetail;

  const CardUnitAndExplain({required this.cardDetail,super.key});

  @override
  State<CardUnitAndExplain> createState() => _CardUnitAndExplainState();
}

class _CardUnitAndExplainState extends State<CardUnitAndExplain> {
  int? focusIndex;
  late List<CardDetailModel> units = widget.cardDetail.detailCards;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(units.isEmpty) return CircularProgressIndicator();

    return Column(
      children: [
        SizedBox(
          height: 35.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              return TextButton(onPressed: (){
                if(focusIndex != index) {
                  focusIndex = index;
                }
                else {
                  focusIndex = null;
                }
                setState(() {});
              }, child: Text(units[index].unit));
            },
            itemCount: units.length,
          ),
        ),
        if(focusIndex != null)
          renderDetail()
      ],
    );
  }


  Widget renderDetail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('unit : ${units[focusIndex!].unit}'),
        Divider(),
        Text('explain : ${units[focusIndex!].explain}'),
      ],
    );
  }
}
