import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';

class ActionIcon extends StatelessWidget {
  final String field;
  // final String uid;
  final String timestamp;
  final dynamic iconStyle;

  const ActionIcon({
    Key key,
    @required this.field,
    // @required this.uid,
    @required this.timestamp,
    @required this.iconStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final sb = context.watch<SigninBloc>();

    if (sb.isSignedIn == false) return this.iconStyle.normal;
    return StreamBuilder(
      stream: firestore.collection('users').doc(sb.uid).snapshots(),
      builder: (context, snap) {
        if (sb.uid == null) return this.iconStyle.normal;
        if (!snap.hasData) return this.iconStyle.normal;
        List data = snap.data[field];

        if (data.contains(timestamp)) {
          return this.iconStyle.bold;
        } else {
          return this.iconStyle.normal;
        }
      },
    );
  }
}

class ActionIconText extends StatelessWidget {
  final String field;
  final String timestamp;

  const ActionIconText({
    Key key,
    @required this.field,
    @required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    return StreamBuilder(
      stream: firestore.collection('locations').doc(this.timestamp).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return Text('--');
        int data = snap.data[this.field] as int;
        return Text(data.toString());
      },
    );
  }
}
