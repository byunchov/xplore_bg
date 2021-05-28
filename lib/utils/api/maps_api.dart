import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xplore_bg/models/restaurant.dart';
import 'package:xplore_bg/utils/api/failure.dart';
import 'package:xplore_bg/utils/config.dart';

class MapsRESTApi {
  Future<List<Restaurant>> fetchRestData(
      double lat, double lng, String locale) async {
    String dataUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=5000&type=restaurant&language=$locale&key=${AppConfig.mapsAPIKey}';

    List<Restaurant> _results = [];
    try {
      final response = await http.get(dataUrl);
      var decodedData = jsonDecode(response.body);
      if (decodedData['results'].isEmpty) {
        throw EmptyResult('no_results_found');
      } else {
        String thumb;
        for (var i = 0; i < decodedData['results'].length; i++) {
          if (decodedData['results'][i]['photos'] == null) {
            thumb = decodedData['results'][i]['icon'];
          } else {
            thumb =
                "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${decodedData['results'][i]['photos'][0]['photo_reference']}&key=${AppConfig.mapsAPIKey}";
          }

          Restaurant restaurant = Restaurant(
            id: decodedData['results'][i]['place_id'],
            name: decodedData['results'][i]['name'],
            address: decodedData['results'][i]['vicinity'] ?? '',
            rating: decodedData['results'][i]['rating'] ?? 0.0,
            lat: decodedData['results'][i]['geometry']['location']['lat']
                    .toDouble() ??
                0.0,
            lng: decodedData['results'][i]['geometry']['location']['lng']
                    .toDouble() ??
                0.0,
            priceLevel: decodedData['results'][i]['price_level'] ?? 0,
            thumbnail: thumb,
          );

          _results.add(restaurant);
        }
        _results.sort((a, b) => b.rating.compareTo(a.rating));
        return _results;
      }
    } on SocketException {
      throw Failure('no_internet');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }
}
