class Place {
  String uid;
  String name;
  String state;
  String location;
  String category;
  String subcategory;
  double latitude;
  double longitude;
  String description;
  List<String> gallery;
  int loves;
  int commentCount;
  double starRating;
  String date;
  String timestamp;

  Place({
    this.uid,
    this.state,
    this.name,
    this.location,
    this.latitude,
    this.longitude,
    this.description,
    this.gallery,
    this.loves,
    this.commentCount,
    this.date,
    this.timestamp,
    this.category,
    this.subcategory,
    this.starRating,
  });
}
