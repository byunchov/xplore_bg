import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:xplore_bg/models/helpers.dart';

class SubcategoryListBloc extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<SubcategoryCheckBox>> getCategoryList(
      String cat, String locale) async {
    List<SubcategoryCheckBox> subcategories = [];

    final ref =
        firestore.collection('subcategories').where('category', isEqualTo: cat);
    var snap = await ref.get();
    var docs = snap.docs;

    if (docs.isNotEmpty) {
      subcategories = docs
          .map((cat) => SubcategoryCheckBox.fromFirestore(cat, locale))
          .toList();
    }
    return subcategories;
  }
}
