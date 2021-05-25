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
  String categoryTag;
  String regionTag;
  String subcategoryTag;

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
    this.categoryTag,
    this.subcategory,
    this.subcategoryTag,
    this.region,
    this.regionTag,
    this.starRating,
    this.locale,
    this.placeTranslation,
  });

  factory Place.fromFirestore(DocumentSnapshot snapshot, String locale) {
    var data = snapshot.data();
    return Place(
      latitude: (data['coordinates']['lat'] ?? 0).toDouble(),
      longitude: (data['coordinates']['lng'] ?? 0).toDouble(),
      gallery: List<String>.from(data['gallery']),
      timestamp: data['timestamp'] as String,
      region: data['region_tr'][locale] as String,
      category: data['category_tr'][locale] as String,
      subcategory: data['subcategory_tr'][locale] as String,
      reviewsCount: data['reviews_count'] as int ?? 0,
      loves: data['loves_count'] as int,
      bookmarksCount: data['bookmarks_count'] as int,
      starRating: (data['rating'] ?? 0.0).toDouble(),
      categoryTag: data['category'] as String,
      subcategoryTag: data['subcategory'] as String,
      regionTag: data['region'] as String,
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
