import 'package:flutter/material.dart';

class SimpleDialogueBox extends StatelessWidget {
  String title,
    description;

  SimpleDialogueBox({this.title,this.description});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      titlePadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(50),
      children: [
        Container(
            child: Text(description)
        ),
      ]
    );
  }

  Future show(context) async {
    return await showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }


}