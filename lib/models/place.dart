class Place {
  String uid;
  String name;
  String state;
  String location;
  double latitude;
  double longitude;
  String description;
  List<String> gallery;
  int loves;
  int commentCount;
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
  });
}
