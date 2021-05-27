import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg/pages/categories.dart';

class LandmarksPage extends StatefulWidget {
  @override
  _LandmarksPageState createState() => _LandmarksPageState();
}

class _LandmarksPageState extends State<LandmarksPage>
    with AutomaticKeepAliveClientMixin<LandmarksPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('menu_landmarks').tr(),
        automaticallyImplyLeading: false,
      ),
      body: CategotiesTab(),
    );
  }
}
