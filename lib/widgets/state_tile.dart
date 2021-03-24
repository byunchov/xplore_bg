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
    return InkWell(
      child: Container(
        height: 150,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2.0,
                      blurRadius: 8.0),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  stateModel.thumbnail,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black45,
                      Colors.transparent,
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
            ),
          ),
        );
      },
    );
  }
}
