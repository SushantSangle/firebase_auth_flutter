import 'package:flutter/material.dart';


class TextFieldBox extends StatelessWidget{
  String labelText;
  TextEditingController controller;
  Function(String) textValidator;
  TextInputType keyboardType;
  bool obscureText;
  int maxLines;
  bool disabled;
  double width;
  IconData prefixIcon;
  Widget suffix;
  TextFieldBox({this.labelText,
    this.controller,
    this.textValidator,
    this.obscureText = false,
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
    this.disabled = false,
    this.width,
    this.prefixIcon,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
            enabled: !disabled,
            textAlignVertical: TextAlignVertical.center,
            maxLines: maxLines,
            readOnly: disabled,
            controller: this.controller,
            obscureText: this.obscureText,
            validator: this.textValidator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: this.labelText,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
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
              labelStyle: TextStyle(
                inherit: true,
                fontSize: 20,
              ),
              prefixIcon: prefixIcon != null ? Icon(
                prefixIcon,
              ) : Container(),
            )
        ),
      ),
    );
  }
}