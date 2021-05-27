import 'package:cloud_firestore/cloud_firestore.dart';

class SubcategoryCheckBox {
  String name;
  String tag;
  bool value;

  SubcategoryCheckBox({
    this.name,
    this.tag,
    this.value = false,
  });

  factory SubcategoryCheckBox.fromFirestore(
      DocumentSnapshot snapshot, String locale) {
    var data = snapshot.data();
    return SubcategoryCheckBox(
      name: data['locales'][locale],
      tag: data['tag'],
    );
  }
}

class OrderDirection {
  String name;
  String tag;

  OrderDirection({
    this.name,
    this.tag,
  });
}

class FilterCtiteria {
  String name;
  String tag;

  FilterCtiteria({
    this.name,
    this.tag,
  });
}
