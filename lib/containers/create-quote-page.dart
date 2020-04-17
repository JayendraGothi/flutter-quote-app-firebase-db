import 'package:flutter/material.dart';
import 'package:flutterfirebaseapp/components/create-quote-form.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../palette.dart';

class CreateQuotePage extends StatefulWidget {
  @override
  State createState() => new _CreateQuotePageState();
}

class _CreateQuotePageState extends State<CreateQuotePage> {
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Create Quote'), backgroundColor: Palette.secondaryColor),
      backgroundColor: Palette.primaryColor,
      body: new Theme(
        data: theme(),
        isMaterialAppTheme: true,
        child: Builder(
          builder: (context) {
            return new SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        child: this.renderForm(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 30.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Render pin forms
  Widget renderForm() {
    return CreateQuoteForm();
  }

  /// prepare theme data
  theme() {
    return ThemeData(
      buttonTheme: ButtonThemeData(
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: new RoundedRectangleBorder(
          side: BorderSide(width: 0.0, color: Colors.grey[300]),
          borderRadius: new BorderRadius.circular(0.0),
        ),
      ),
      textTheme: TextTheme(
        button: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        title: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w100,
          color: Colors.blue,
        ),
        display1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        display2: TextStyle(
          fontSize: 16.0,
          color: Colors.grey[600],
        ),
      ),
      fontFamily: 'OpenSans',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[200],
        hintStyle: TextStyle(color: Palette.primaryLightColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
          borderSide: BorderSide(color: Colors.grey[200], width: 0.0),
        ),
      ),
    );
  }
}
