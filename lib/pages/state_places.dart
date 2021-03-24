import 'package:flutter/material.dart';
import 'package:xplore_bg/models/state.dart';

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
            backgroundColor: (widget.appBarColor != null)
                ? widget.appBarColor
                : Theme.of(context).primaryColor,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
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
                        colors: [Colors.transparent, Colors.black45],
                      ),
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
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => ListTile(title: Text('Item #$index')),
              // Builds 1000 ListTiles
              childCount: 1000,
            ),
          ),
        ],
      ),
    );
  }
}
