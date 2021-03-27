import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:xplore_bg/pages/blank_page.dart';

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('menu_bookmarks').tr(),
          bottom: TabBar(
            // indicatorColor: Theme.of(context).primaryColor,
            indicator: MaterialIndicator(
              height: 4,
              color: Theme.of(context).primaryColor,
              horizontalPadding: 10,
              topLeftRadius: 4,
              topRightRadius: 4,
              paintingStyle: PaintingStyle.fill,
            ),
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text('favourites').tr(),
              ),
              Tab(
                child: Text('bookmarks').tr(),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlankPage(
              heading: tr('no_favourites'),
              shortText: tr('no_favourites_desc'),
              icon: Feather.heart,
            ),
            BlankPage(
              heading: tr('no_bookmarks'),
              shortText: tr('no_bookmarks_desc'),
              icon: Feather.bookmark,
              divider: true,
            ),
          ],
        ),
      ),
    );
  }
}
