import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  String uid;
  String name;
  String state;
  String residence;
  String category;
  String subcategory;
  double latitude; //
  double longitude; //
  String description;
  List<String> gallery; //
  int loves; // lovesCount
  int reviewsCount; //
  int bookmarksCount; //
  double starRating; //
  String date;
  String timestamp; //
  String locale;
  String region;
  PlaceTranslation placeTranslation;

  Place({
    this.uid,
    this.state,
    this.name,
    this.residence,
    this.latitude,
    this.longitude,
    this.description,
    this.gallery,
    this.loves,
    this.reviewsCount,
    this.bookmarksCount,
    this.date,
    this.timestamp,
    this.category,
    this.subcategory,
    this.starRating,
    this.locale,
    this.region,
    this.placeTranslation,
  });

  factory Place.fromFirestore(DocumentSnapshot snapshot, String locale) {
    var data = snapshot.data();
    return Place(
      latitude: data['coordinates']['lat'] as double,
      longitude: data['coordinates']['lng'] as double,
      gallery: List<String>.from(data['gallery']),
      timestamp: data['timestamp'] as String,
      region: data['region_tr'][locale] as String,
      category: data['category_tr'][locale] as String,
      subcategory: data['subcategory_tr'][locale] as String,
      reviewsCount: data['reviews_count'] as int ?? 0,
      loves: data['loves_count'] as int,
      bookmarksCount: data['bookmarks_count'] as int,
      starRating: data['rating'] as double ?? 0.0,
    );
  }
}

class PlaceTranslation {
  String name;
  String residence;
  String description;

  PlaceTranslation({this.name, this.residence, this.description});
  factory PlaceTranslation.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data();

    return PlaceTranslation(
      name: data['name'] as String,
      residence: data['residence'] as String,
      description: data['description'] as String,
    );
  }
}
