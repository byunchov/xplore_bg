import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/models/state.dart';
import 'package:xplore_bg/widgets/place_item_states.dart';

class StatePlaces extends StatefulWidget {
  final StateModel stateModel;
  final Color appBarColor;

  const StatePlaces({Key key, this.stateModel, this.appBarColor})
      : super(key: key);

  @override
  _StatePlacesState createState() => _StatePlacesState();
}

class _StatePlacesState extends State<StatePlaces> {
  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    // double _sliverradius = 30;

    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
            backgroundColor:
                widget.appBarColor ?? Theme.of(context).primaryColor,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(_sliverradius),
                    //     bottomRight: Radius.circular(_sliverradius),
                    //   ),
                    // ),
                    child: Image.network(
                      widget.stateModel.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black38.withOpacity(0.6)
                        ],
                      ),
                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: Radius.circular(_sliverradius),
                      //   bottomRight: Radius.circular(_sliverradius),
                      // ),
                    ),
                  ),
                ],
              ),
              title: Text(
                widget.stateModel.name.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              titlePadding: EdgeInsets.only(left: 20, bottom: 15),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            sliver: SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => PlaceItemState(
                  tag: "sate$index",
                  place: Place(
                    name: "Place $index",
                    location: "town $index, Plaxe $index",
                    loves: Random().nextInt(100) + 10,
                    commentCount: Random().nextInt(100) + 10,
                    gallery: <String>[
                      "http://infomreja.bg/upload/articles/images/18387/024ec2c710680539c9257aa4a27fd7d5.jpg",
                    ],
                  ),
                ),
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
