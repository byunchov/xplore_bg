import 'package:flutter/material.dart';

String removeHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

String removeEscapedHtml(String htmlText) {
  RegExp exp = RegExp(r"&[^;]*;", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

void showSnackbar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(
          message,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
    ),
  );
}

void showSnackbarold(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
    String message) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(
          message,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
    ),
  );
}
