import 'package:flutter/material.dart';

class TextFieldBox extends StatelessWidget{
  String labelText;
  TextEditingController controller;
  Function(String) textValidator;
  TextInputType keyboardType;
  bool obscureText;
  int maxLines;
  TextFieldBox({this.labelText,this.controller,this.textValidator,this.obscureText = false, this.keyboardType = TextInputType.name,this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: this.maxLines,
            controller: this.controller,
            obscureText: this.obscureText,
            validator: this.textValidator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: this.labelText,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red[600],
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red[600],
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.indigo[900],
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            )
        ),
      ),
    );
  }
}