import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String removeHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

String removeEscapedHtml(String htmlText) {
  RegExp exp = RegExp(r"&[^;]*;", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

String getTimestamp() {
  final DateTime now = DateTime.now();
  return DateFormat('yyyyMMddTHHmmss').format(now);
}

String parseDate(String date, String locale) {
  final dt = DateTime.parse(date);
  return DateFormat.yMd(locale).format(dt);
}

void showSnackbar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(
          message.toString(),
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
