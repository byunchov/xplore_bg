class AppConfig {
  static final String appName = "Xplore Bulgaria";
  static final List<String> appLanguages = ["Български", "English"];
  static final List<String> appLocales = ["bg", "en"];

  //google maps
  static final String mapsAPIKey = "AIzaSyDpkUJqyeoqveQoWlvQvXeNwRceopftryo";
  static final String hotelIcon = 'assets/images/maps/hotel.png';
  static final String restaurantIcon = 'assets/images/maps/restaurant.png';
  static final String hotelPinIcon = 'assets/images/maps/hotel_pin.png';
  static final String restaurantPinIcon =
      'assets/images/maps/restaurant_pin.png';

  //user related
  static final String defaultProfilePic =
      'https://www.seekpng.com/png/detail/114-1149972_avatar-free-png-image-avatar-png.png';

  static final String mailto =
      "mailto:$supportEmail?subject=About $appName App&body=";

  static final String supportEmail = 'proektpmu@gmail.com';
}
