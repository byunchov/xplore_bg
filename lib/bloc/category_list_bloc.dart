import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:xplore_bg/models/category_tile.dart';

class CategoryListBloc extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<CategoryItem>> getCategoryList(String locale) async {
    List<CategoryItem> categories = [];

    final ref = firestore.collection('categories');
    var snap = await ref.get();
    var docs = snap.docs;
    // print("In category bloc:");
    // print(docs);

    if (docs.isNotEmpty) {
      print("In category bloc iteratior:");
      categories =
          docs.map((cat) => CategoryItem.formFirestore(cat, locale)).toList();
    }
    return categories;
  }
}
