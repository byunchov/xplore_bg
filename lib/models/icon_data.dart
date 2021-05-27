import 'package:flutter/material.dart';

final double actionIconSize = 26;

class LoveIcon {
  Icon normal = Icon(Icons.favorite_border, size: actionIconSize);
  Icon bold = Icon(
    Icons.favorite,
    color: Colors.red,
    size: actionIconSize,
  );
}

class BookmarkIcon {
  Icon normal = Icon(Icons.bookmark_border, size: actionIconSize);
  Icon bold = Icon(
    Icons.bookmark,
    color: Colors.blue,
    size: actionIconSize,
  );
}
