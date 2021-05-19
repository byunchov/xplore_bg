import 'package:xplore_bg/models/gallery.dart';
import 'package:xplore_bg/models/review.dart';

class Restaurant {
  String id;
  String name;
  String address;
  double lat;
  double lng;
  var rating;
  int priceLevel;
  bool openNow;
  String thumbnail;

  Restaurant({
    this.id,
    this.name,
    this.address,
    this.lat,
    this.lng,
    this.rating,
    this.priceLevel,
    this.openNow,
    this.thumbnail,
  });
}

class RestaurantDetails {
  String id;
  String name;
  String address;
  double lat;
  double lng;
  var rating;
  var priceLevel;
  int totalRatings;
  String website;
  List<dynamic> openingHours;
  String phoneNumber;
  List<Gallery> gallery;
  String url;
  List<Review> reviews;

  RestaurantDetails({
    this.name,
    this.address,
    this.lat,
    this.lng,
    this.rating,
    this.priceLevel,
    this.gallery,
    this.openingHours,
    this.phoneNumber,
    this.reviews,
    this.totalRatings,
    this.url,
    this.website,
  });
}
