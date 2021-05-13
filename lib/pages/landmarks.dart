import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:xplore_bg/pages/categories.dart';
import 'package:xplore_bg/pages/country_states.dart';

class LandmarksPage extends StatefulWidget {
  @override
  _LandmarksPageState createState() => _LandmarksPageState();
}

class _LandmarksPageState extends State<LandmarksPage>
    with AutomaticKeepAliveClientMixin<LandmarksPage> {
  List<Tab> _listTabs;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _listTabs = <Tab>[
      Tab(
        child: Text('tab_categories').tr(),
      ),
      Tab(
        child: Text('tab_states').tr(),
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: _listTabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('menu_landmarks').tr(),
          bottom: TabBar(
            indicator: MaterialIndicator(
              height: 4,
              color: Theme.of(context).primaryColor,
              horizontalPadding: 10,
              topLeftRadius: 4,
              topRightRadius: 4,
              paintingStyle: PaintingStyle.fill,
            ),
            labelColor: Colors.black,
            tabs: _listTabs,
          ),
        ),
        body: TabBarView(
          children: [
            CategotiesTab(),
            StatesPage(),
          ],
        ),
      ),
    );
  }
}
