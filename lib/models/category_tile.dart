import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryItem {
  String name;
  String thumbnail;
  String tag;
  int itemCount;

  CategoryItem({this.name, this.itemCount, this.thumbnail, this.tag});

  factory CategoryItem.formFirestore(DocumentSnapshot snapshot, String locale) {
    var data = snapshot.data();
    return CategoryItem(
      itemCount: data['item_count'],
      thumbnail: data['thumbnail'],
      name: data['locales'][locale] ?? data['locales']['bg'],
      tag: data['tag'],
    );
  }
}
