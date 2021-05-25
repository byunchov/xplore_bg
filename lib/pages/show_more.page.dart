import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/widgets/place_item_states.dart';

class ShowMorePage extends StatefulWidget {
  final String title;
  final String page;

  const ShowMorePage({Key key, this.title, this.page}) : super(key: key);
  @override
  _ShowMorePageState createState() => _ShowMorePageState();
}

class _ShowMorePageState extends State<ShowMorePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String collectionName = 'locations';
  List<DocumentSnapshot> _snap = new List<DocumentSnapshot>();
  List<Place> _data = [];
  ScrollController _controller;
  DocumentSnapshot _lastVisible;
  bool _isLoading;
  bool _descending;
  String _orderBy;

  String _locale;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    if (widget.page == 'popular') {
      _orderBy = 'loves_count';
      _descending = true;
    } else if (widget.page == 'recent') {
      _orderBy = 'reviews_count';
      _descending = true;
    } else {
      _orderBy = 'timestamp';
      _descending = false;
    }
    Future.delayed(Duration(microseconds: 50)).then((_) {
      _controller = ScrollController()..addListener(_scrollListener);
      _getData(_locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    _locale = context.locale.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Feather.rotate_ccw),
            onPressed: () {
              onRefresh();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(15),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < _data.length) {
                      return PlaceItemState(
                        place: _data[index],
                        tag: '${widget.title}$index',
                      );
                    }
                    return Opacity(
                      opacity: _isLoading ? 1.0 : 0.0,
                      child: _lastVisible == null
                          ? Column(
                              children: [
                                LoadingCard(cardHeight: 180),
                                SizedBox(height: 15)
                              ],
                            )
                          : Center(
                              child: SizedBox(
                                width: 32.0,
                                height: 32.0,
                                child: new CircularProgressIndicator(),
                              ),
                            ),
                    );
                  },
                  childCount: _data.length == 0 ? 5 : _data.length + 1,
                ),
              ),
            )
          ],
        ),
        onRefresh: onRefresh,
      ),
    );
  }

  void _scrollListener() {
    if (!_isLoading) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
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
    if (_lastVisible == null) {
      data = await firestore
          .collection(collectionName)
          .orderBy(_orderBy, descending: _descending)
          .limit(5)
          .get();
    } else {
      data = await firestore
          .collection(collectionName)
          .orderBy(_orderBy, descending: _descending)
          .startAfter([_lastVisible[_orderBy]])
          .limit(5)
          .get();
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
          _isLoading = false;
          _data.addAll(places);
        });
      }
    } else {
      setState(() => _isLoading = false);
    }
  }
}
