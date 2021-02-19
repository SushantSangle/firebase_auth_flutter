import 'package:flutter/material.dart';

class InfoField extends StatelessWidget{
  final String fieldData;
  final String fieldInfo;
  final bool lastEntry;

  InfoField({this.fieldInfo,this.fieldData, this.lastEntry = false});

  @override
  build(BuildContext context){
    if(fieldData == null)
      return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 5, 0, 2),
          child: Text(
            fieldInfo,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 2, 0, 5),
          child: Text(
            fieldData,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        this.lastEntry? Container() :Divider(
          thickness: 2,
        ),
      ],
    );
  }
}