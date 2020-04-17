import 'package:flutter/material.dart';

/// app form field widget
class AppFormField extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String error;
  final bool obscureText;
  final int maxLines;

  // constructor
  AppFormField(
      {Key key,
      @required this.placeholder,
      this.icon,
      @required this.controller,
      this.keyboardType = TextInputType.text,
      this.error,
      this.obscureText = false,
      this.maxLines = 1})
      : super(key: key);

  /// app text field
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          obscureText: this.obscureText,
          controller: controller,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.display1,
          decoration: InputDecoration(
            hintText: placeholder,
          ),
          keyboardType: keyboardType,
        ),
        Padding(padding: EdgeInsets.only(right: 10), child: errorMessage())
      ],
    );
  }

  /// error message
  errorMessage() {
    if (error != null && error.length > 0)
      return Text(error, style: TextStyle(color: Colors.red, fontSize: 14));
    return Padding(padding: EdgeInsets.all(0));
  }
}
