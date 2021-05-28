import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/search_bloc.dart';
import 'package:xplore_bg/pages/blank_page.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/utils/misc.dart';
import 'package:xplore_bg/widgets/categories/category_card_2.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //search bar
                Container(
                  alignment: Alignment.center,
                  height: 56,
                  width: _screenWidth,
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextFormField(
                    autofocus: true,
                    controller: context.watch<SearchBloc>().textfieldCtrl,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: tr("search_places"),
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800]),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 15),
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_backspace,
                            color: Colors.grey[800],
                          ),
                          color: Colors.grey[800],
                          onPressed: () {
                            context.read<SearchBloc>().saerchInitialize();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[800],
                          size: 25,
                        ),
                        onPressed: () {
                          context.read<SearchBloc>().saerchInitialize();
                        },
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      if (value == '') {
                        showSnackbarKey(
                            context, _scaffoldKey, tr('inputh_sth'));
                      } else {
                        context.read<SearchBloc>().setSearchText(value);
                        context.read<SearchBloc>().addToSearchList(value);
                      }
                    },
                  ),
                ),

                Container(
                  height: 1,
                  child: Divider(
                    color: Colors.grey[300],
                  ),
                ),

                // suggestion text
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, bottom: 5),
                  child: Text(
                    context.watch<SearchBloc>().searchStarted == false
                        ? 'search_history'
                        : 'search_results',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ).tr(),
                ),
                context.watch<SearchBloc>().searchStarted == false
                    ? SearchSuggestionsUI()
                    : SearchResultsUI()
              ],
            ),
          )),
    );
  }
}

class SearchSuggestionsUI extends StatelessWidget {
  const SearchSuggestionsUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SearchBloc>();
    return Expanded(
      child: sb.recentSearchHistory.isEmpty
          ? BlankPage(
              icon: Feather.clipboard,
              heading: tr('no_places_found'),
              shortText: tr('try_again'),
            )
          : ListView.builder(
              itemCount: sb.recentSearchHistory.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    sb.recentSearchHistory[index],
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(Icons.history),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      context
                          .read<SearchBloc>()
                          .removeFromSearchList(sb.recentSearchHistory[index]);
                    },
                  ),
                  onTap: () {
                    context
                        .read<SearchBloc>()
                        .setSearchText(sb.recentSearchHistory[index]);
                  },
                );
              },
            ),
    );
  }
}

class SearchResultsUI extends StatelessWidget {
  const SearchResultsUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _locale = context.locale.toString();
    return Expanded(
      child: FutureBuilder(
        future: context.watch<SearchBloc>().fetchData(_locale),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return BlankPage(
                icon: Feather.clipboard,
                heading: tr('no_places_found'),
                shortText: tr('try_again'),
              );
            } else {
              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemBuilder: (_, int index) {
                  return CategoryListItem2(
                    place: snapshot.data[index],
                  );
                },
              );
            }
          }
          return ListView.separated(
            padding: EdgeInsets.all(15),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            separatorBuilder: (_, int index) => SizedBox(height: 10),
            itemBuilder: (_, int index) => CategoryLoadingCard2(),
          );
        },
      ),
    );
  }
}
