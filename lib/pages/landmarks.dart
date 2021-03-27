import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:xplore_bg/pages/blank_page.dart';
import 'package:xplore_bg/pages/categories.dart';
import 'package:xplore_bg/pages/country_states.dart';

class LandmarksPage extends StatelessWidget {
  final List<Tab> _listTabs = <Tab>[
    Tab(
      child: Text('tab_categories').tr(),
    ),
    Tab(
      child: Text('tab_states').tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
            // BlankPage(
            //   heading: "No categories",
            //   icon: Feather.list,
            // ),
            CategotiesTab(),
            StatesPage(),
          ],
        ),
      ),
    );
  }
}
