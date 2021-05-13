import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void nextScreenMaterial(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
