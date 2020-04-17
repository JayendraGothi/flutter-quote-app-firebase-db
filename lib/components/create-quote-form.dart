import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseapp/containers/quote-list.dart';

import '../palette.dart';
import 'app-flat-button.dart';
import 'app-form-field.dart';

class CreateQuoteForm extends StatefulWidget {
  @override
  State createState() => new _CreateQuoteFormState();
}

class _CreateQuoteFormState extends State<CreateQuoteForm> {
  final quote = TextEditingController();
  final author = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // generate pin
  void create() {
    var data = new Map<String, dynamic>();
    data['quote'] = this.quote.text;
    data['author'] = this.author.text;
    data['dislikes'] = 0;
    data['likes'] = 0;
    data['share_count'] = 0;
    data['comments'] = [];

    Firestore.instance.collection('quotes').document().setData(data);
    this.quoteCreated();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 0, bottom: 20.0),
            child: new Text(
              "Create Quote",
              textAlign: TextAlign.center,
              style: TextStyle(color: Palette.secondaryColor, fontSize: 30.0),
            ),
          ),
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: new Text(
              "Fill deatils to create quote.",
              style: TextStyle(
                  color: Palette.primaryColor, fontWeight: FontWeight.w200),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: AppFormField(
              placeholder: "Quote",
              controller: quote,
              keyboardType: TextInputType.text,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: AppFormField(
              placeholder: "Author",
              icon: Icons.phone_in_talk,
              controller: author,
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          new SizedBox(
            width: double.infinity,
            child: new AppFlatButton(
              text: Text("SUBMIT", style: Theme.of(context).textTheme.button),
              onPressed: this.create,
              loadingMessage: "SUBMITTING...",
            ),
          ),
        ],
      ),
    );
  }

  goToQuoteList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuoteListPage(),
      ),
    );
  }

  /// Back button clicked callback
  quoteCreated() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text("Quote created successfully."),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              this.goToQuoteList();
            },
            child: new Text(
              'Close',
              style: TextStyle(color: Palette.dangerColor),
            ),
          )
        ],
      ),
    );
  }
}
