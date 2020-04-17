import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebaseapp/palette.dart';
import 'package:flutterfirebaseapp/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuoteApp(),
    );
  }
}

class QuoteApp extends StatefulWidget {
  @override
  _QuoteAppState createState() => new _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  final String title = 'Online Exam';

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.setStatusBarColor();
    return new MaterialApp(
      title: title,
      theme: appTheme(),
      routes: routes,
    );
  }

  /// sets status bar color
  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Palette.secondaryColor, statusBarIconBrightness: Brightness.light));
  }

  /// App theme
  appTheme() {
    return ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: Palette.primaryColor,
        backgroundColor: Palette.primaryBackgroundColor,
    );
  }
}
