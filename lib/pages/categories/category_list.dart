import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg/models/category_tile.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/blank_page.dart';
import 'package:xplore_bg/pages/categories/filtering_page.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/categories/category_card_2.dart';

class CategoryListPage extends StatefulWidget {
  final CategoryItem caterory;

  const CategoryListPage({Key key, this.caterory}) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collectionName = 'locations';
  final String _mainField = 'category';
  String _orderBy = 'loves_count';
  List<DocumentSnapshot> _snap = [];
  List<Place> _data = [];
  var _subcategories = <String>[];
  ScrollController _controller;
  DocumentSnapshot _lastVisible;
  bool _isLoading;
  bool _hasData;
  bool _descending = true;
  String _locale;
  String _subField = 'subcategory';
  Map _lastFilters;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasData = true;
    _controller = ScrollController()..addListener(_scrollListener);
    Future.delayed(Duration(microseconds: 20)).then((_) {
      _getData(_locale);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _locale = context.locale.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.caterory.name),
        actions: [
          _hasData
              ? IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () async {
                    Map filters = await nextScreenMaterial(
                      context,
                      FilteringPage(
                        category: widget.caterory,
                        filters: _lastFilters,
                      ),
                    );
                    print(filters);
                    if (filters != null) {
                      setState(() {
                        _subcategories =
                            List<String>.from(filters['subcategories']);
                        _descending = (filters['order_by'] ?? true) as bool;
                        _orderBy =
                            (filters['field'] ?? "loves_count") as String;
                        // _lastFilters.clear();
                        _lastFilters = filters;
                      });
                      onRefresh();
                    }
                    print(_lastFilters);
                  },
                )
              : IconButton(
                  icon: Icon(Feather.rotate_cw),
                  onPressed: onRefresh,
                )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: !_hasData
            ? ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.32,
                  ),
                  BlankPage(
                    heading: "Nothing found!",
                    shortText: "No places found in this category!",
                    icon: Icons.list_alt_outlined,
                  ),
                ],
              )
            : ListView.separated(
                padding: EdgeInsets.all(15),
                controller: _controller,
                physics: _isLoading
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: _data.length == 0 ? 5 : _data.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < _data.length) {
                    return CategoryListItem2(
                      place: _data[index],
                    );
                  }
                  return _isLoading
                      ? Opacity(
                          // opacity: _isLoading ? 1.0 : 0.0,
                          opacity: 1.0,
                          child: _lastVisible == null
                              ? CategoryLoadingCard2()
                              : Center(
                                  child: SizedBox(
                                    width: 32.0,
                                    height: 32.0,
                                    child: new CircularProgressIndicator(),
                                  ),
                                ),
                        )
                      : Container();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 15);
                },
              ),
      ),
    );
  }

  void _scrollListener() {
    if (!_isLoading) {
      // if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() => _isLoading = true);
        _getData(_locale);
      }
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      _snap.clear();
      _data.clear();
      _isLoading = true;
      _lastVisible = null;
    });
    _getData(_locale);
  }

  Future<void> _getData(String locale) async {
    List<Place> places = [];
    QuerySnapshot data;
    setState(() => _hasData = true);
    if (_lastVisible == null) {
      if (_subcategories.isEmpty || _subcategories == null) {
        data = await firestore
            .collection(_collectionName)
            .where(_mainField, isEqualTo: widget.caterory.tag)
            .orderBy(_orderBy, descending: _descending)
            .limit(7)
            .get();
      } else {
        print("Got subs: $_subcategories");
        data = await firestore
            .collection(_collectionName)
            .where(_mainField, isEqualTo: widget.caterory.tag)
            .where(_subField, whereIn: _subcategories)
            .orderBy(_orderBy, descending: _descending)
            .limit(7)
            .get();
      }
    } else {
      if (_subcategories.isEmpty || _subcategories == null) {
        data = await firestore
            .collection(_collectionName)
            .where(_mainField, isEqualTo: widget.caterory.tag)
            .orderBy(_orderBy, descending: _descending)
            .startAfterDocument(_lastVisible)
            .limit(7)
            .get();
      } else {
        data = await firestore
            .collection(_collectionName)
            .where(_mainField, isEqualTo: widget.caterory.tag)
            .where(_subField, whereIn: _subcategories)
            .orderBy(_orderBy, descending: _descending)
            .startAfterDocument(_lastVisible)
            .limit(7)
            .get();
      }
    }

    if (data != null && data.docs.length > 0) {
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        _snap.addAll(data.docs);
        for (var item in _snap) {
          var locRef = item.reference.collection('locales').doc(locale);
          var trData = await locRef.get();
          Place p = Place.fromFirestore(item, locale);
          p.placeTranslation = PlaceTranslation.fromFirebase(trData);
          places.add(p);
        }

        setState(() {
          _data = places;
          // _data.addAll(places);
          _isLoading = false;
        });
      }
    } else {
      // setState(() => _isLoading = false);
      if (_lastVisible == null) {
        setState(() {
          _isLoading = false;
          _hasData = false;
          print('no items');
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasData = true;
          print('no more items');
        });
      }
    }
  }
}

