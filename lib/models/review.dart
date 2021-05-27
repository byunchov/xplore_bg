import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String authorName;
  String profilePicture;
  var rating;
  String relativeTimeDescription;
  String text;
  String dateAdded;
  String timestamp;
  String uid;

  Review({
    this.authorName,
    this.profilePicture,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.dateAdded,
    this.timestamp,
    this.uid,
  });

  factory Review.fromFirestore(DocumentSnapshot snap) {
    var data = snap.data();

    return Review(
      authorName: data['author'],
      profilePicture: data['image_url'],
      timestamp: data['timestamp'],
      text: data['content'],
      rating: (data['rating'] ?? 0).toDouble(),
      uid: data['uid'],
    );
  }
}
