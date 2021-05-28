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
      return AlertDialog(
        title: title != null ? Text(title) : Container(),
        content: message != null ? Text(message) : Container(),
        actions: [
          FlatButton(
            child: Text('no').tr(),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text('yes').tr(),
            onPressed: onConfirm,
          )
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
        title: Text('not_signed_in').tr(),
        content: Text('not_signed_in_desc').tr(),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
                nextScreenPopup(context, LoginScreen(tag: 'popup'));
              },
              child: Text('signin_btn').tr()),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel_btn').tr(),
          )
        ],
      );
    },
  );
}
