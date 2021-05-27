import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:xplore_bg/pages/sign_in.dart';
import 'package:xplore_bg/utils/page_navigation.dart';

void showYesNoDialog(BuildContext context, Function onConfirm,
    {String title, String message}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        contentPadding: EdgeInsets.all(50),
        elevation: 0,
        children: <Widget>[
          message != null
              ? Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                )
              : Container(),
          SizedBox(height: 10),
          message != null
              ? Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : Container(),
          SizedBox(height: 30),
          Center(
              child: Row(
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.redAccent,
                child: Text(
                  'yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
                onPressed: onConfirm,
              ),
              SizedBox(width: 10),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Colors.deepPurpleAccent,
                child: Text(
                  'no',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ))
        ],
      );
    },
  );
}

void showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return AlertDialog(
        title: Text('no sign in title').tr(),
        content: Text('no sign in subtitle').tr(),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
                nextScreenPopup(context, LoginScreen(tag: 'popup'));
              },
              child: Text('sign in').tr()),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel').tr(),
          )
        ],
      );
    },
  );
}
