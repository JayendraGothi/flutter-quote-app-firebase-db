import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseapp/components/app-flat-button.dart';
import 'package:flutterfirebaseapp/containers/create-quote-page.dart';
import 'package:flutterfirebaseapp/models/quote.dart';

import '../palette.dart';

class QuoteListPage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<QuoteListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Quotes'), backgroundColor: Palette.secondaryColor),
        body: new Theme(
            data: theme(),
            isMaterialAppTheme: true,
            child: _buildBody(context)),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('quotes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return new Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 5.0),
            children:
                snapshot.map((data) => _buildListItem(context, data)).toList(),
          ),
        ),
        new SizedBox(
          width: double.infinity,
          child: new AppFlatButton(
            text: Text("ADD NEW QUOTE",
                style: Theme.of(context).textTheme.button),
            onPressed: this.goToCreateQuote,
            loadingMessage: "SUBMITTING...",
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = QuoteModel.fromSnapshot(data);

    final _listTitle = Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: <Widget>[
        Text(record.quote, textAlign: TextAlign.left),
        Text("--" + record.author + " --", style: TextStyle(color: Palette.placeholderColor),)
      ],),
    );

    final _listSubTitle = Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Likes:" + record.likes.toString()),
              IconButton(
                icon: Icon(Icons.thumb_up),
                color: Colors.green,
                tooltip: 'Like',
                onPressed: () {
                  print('Pressed Like');
                  Firestore.instance.runTransaction(
                    (transaction) async {
                      final freshSnapshot =
                          await transaction.get(record.reference);
                      final fresh = QuoteModel.fromSnapshot(freshSnapshot);

                      await transaction
                          .update(record.reference, {'likes': fresh.likes + 1});
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              Text("Dislikes:" + record.dislikes.toString()),
              IconButton(
                  icon: Icon(Icons.thumb_down),
                  color: Colors.deepOrangeAccent,
                  tooltip: 'Dislike',
                  onPressed: () {
                    print('Pressed DisLike');
                    Firestore.instance.runTransaction(
                      (transaction) async {
                        final freshSnapshot =
                            await transaction.get(record.reference);
                        final fresh = QuoteModel.fromSnapshot(freshSnapshot);

                        await transaction.update(
                            record.reference, {'dislikes': fresh.dislikes + 1});
                      },
                    );
                  }),
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );

    return Padding(
      key: ValueKey(record.quote),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        child: ListTile(
          trailing: IconButton(
            onPressed: () {
              this.deleteQuote(data);
            },
            icon: Icon(Icons.delete),
          ),
          title: _listTitle,
          subtitle: _listSubTitle,
        ),
      ),
    );
  }

  goToCreateQuote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateQuotePage(),
      ),
    );
  }

  /// Back button clicked callback
  deleteQuote(data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text("Are you sure you want to delete this quote ?"),
        content:
        Text("Choose your option."),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              data.reference.delete();
              Navigator.of(context).pop();
            },
            child: new Text('Submit'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
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
