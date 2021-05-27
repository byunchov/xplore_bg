import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:xplore_bg/bloc/bookmark_bloc.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/pages/blank_page.dart';
import 'package:xplore_bg/pages/categories/category_list.dart';
import 'package:xplore_bg/pages/sign_in.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _sb = context.watch<SigninBloc>();

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('menu_bookmarks').tr(),
          automaticallyImplyLeading: false,
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
            _sb.guestUser ? _notSignedIn() : LovedlacesTab(),
            _sb.guestUser ? _notSignedIn() : BookmarkedPlacesTab(),
          ],
        ),
      ),
    );
  }

  Widget _notSignedIn() {
    return BlankPage(
      heading: "Not Signed in",
      shortText: "Signin to add bookmarks to your list.",
      icon: Feather.log_in,
      divider: false,
      customAction: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          PrimaryButtonRg(
            child: Text("Log in".toUpperCase()),
            onPressed: () {
              nextScreenMaterial(context, LoginScreen(tag: 'bookmarks'));
            },
          ),
        ],
      ),
    );
  }
}

class LovedlacesTab extends StatefulWidget {
  @override
  _LovedlacesTabState createState() => _LovedlacesTabState();
}

class _LovedlacesTabState extends State<LovedlacesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      child: FutureBuilder(
        future: context.watch<BookmarkBloc>().getBookmarksData(
              'loved_places',
              context.locale.toString(),
            ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return BlankPage(
                heading: tr('no_favourites'),
                shortText: tr('no_favourites_desc'),
                icon: Feather.heart,
              );
            } else {
              return ListView.separated(
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => SizedBox(height: 15),
                itemBuilder: (BuildContext context, int index) {
                  return CategoryListItem2(place: snapshot.data[index]);
                },
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class BookmarkedPlacesTab extends StatefulWidget {
  @override
  _BookmarkedPlacesTabState createState() => _BookmarkedPlacesTabState();
}

class _BookmarkedPlacesTabState extends State<BookmarkedPlacesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      child: FutureBuilder(
        future: context.watch<BookmarkBloc>().getBookmarksData(
              'bookmarked_places',
              context.locale.toString(),
            ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return BlankPage(
                heading: tr('no_bookmarks'),
                shortText: tr('no_bookmarks_desc'),
                icon: Feather.bookmark,
                divider: true,
              );
            } else {
              return ListView.separated(
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => SizedBox(height: 15),
                itemBuilder: (BuildContext context, int index) {
                  return CategoryListItem2(place: snapshot.data[index]);
                },
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
