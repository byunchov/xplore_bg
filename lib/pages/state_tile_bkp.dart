import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xplore_bg/models/state.dart';
import 'package:xplore_bg/pages/state_places.dart';

class StateTile extends StatelessWidget {
  final StateModel stateModel;

  const StateTile({
    Key key,
    this.stateModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _cardRadius = 10;
    final double _cardHeight = 150;
    final String _tag = "sates${stateModel.name}";

    return InkWell(
      child: Container(
        height: _cardHeight,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey[400]),
                    borderRadius: BorderRadius.circular(_cardRadius),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2.0,
                          blurRadius: 8.0),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_cardRadius),
                    child: Image.network(
                      stateModel.thumbnail,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(_cardRadius),
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.grey[850].withOpacity(0.3),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.15),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                stateModel.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  // backgroundColor: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatePlaces(
              stateModel: stateModel,
              appBarColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              tag: _tag,
            ),
          ),
        );
      },
    );
  }
}
