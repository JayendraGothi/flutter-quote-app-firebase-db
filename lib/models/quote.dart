import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteModel {
  final String quote;
  final String author;
  final int likes;
  final int dislikes;
  final int shareCount;
  final List comments;
  final DocumentReference reference;

  QuoteModel.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['quote'] != null),
        assert(map['likes'] != null),
        assert(map['dislikes'] != null),
        assert(map['share_count'] != null),
        assert(map['comments'] != null),
        quote = map['quote'],
        author = map['author'],
        likes = map['likes'],
        dislikes = map['dislikes'],
        shareCount = map['share_count'],
        //Notice the difference for array types
        comments = map['comments'] as List;

  QuoteModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$quote:$likes:$dislikes:$shareCount>";
}
