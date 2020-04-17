import 'package:flutter/material.dart';
import 'package:flutterfirebaseapp/palette.dart';

import '../palette.dart';

/// submit button
class AppFlatButton extends StatelessWidget {
  final Text text;
  final VoidCallback onPressed;
  final bool loading;
  final String loadingMessage;
  final Color color;

  const AppFlatButton(
      {Key key,
      this.text,
      this.onPressed,
      this.loading = false,
      this.loadingMessage,
      this.color})
      : super(key: key);

  doNothing() {}

  @override
  Widget build(BuildContext context) {
    if (!loading)
      return new FlatButton(
        color: this.color ?? Palette.secondaryColor,
        child: text,
        onPressed: onPressed,
      );
    else
      return new FlatButton(
        color: Palette.secondaryColor,
        child: new Text(
          this.loadingMessage ?? "LOADING...",
          style: Theme.of(context).textTheme.display2,
        ),
        onPressed: doNothing,
      );
  }
}
