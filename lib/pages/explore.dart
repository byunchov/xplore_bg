import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/feautured_bloc.dart';
import 'package:xplore_bg/bloc/popular_places_bloc.dart';
import 'package:xplore_bg/bloc/recent_places_bloc.dart';
import 'package:xplore_bg/pages/show_more.page.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/featured_widget.dart';
import 'package:xplore_bg/widgets/header.dart';
import 'package:xplore_bg/widgets/home/popular_places.dart';
import 'package:xplore_bg/widgets/home/recent_places.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  String _locale;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 20)).then((_) {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _locale = context.locale.toString() ?? 'bg';
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _refreshData(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                FeaturedPlaces(),
                SizedBox(height: 5),
                PopularPlaces(
                  cardHeight: 250,
                  sectionHeader: tr('most_popular'),
                  onHeaderClick: () {
                    nextScreenMaterial(
                        context,
                        ShowMorePage(
                          page: "popular",
                          title: tr('most_popular'),
                        ));
                  },
                ),
                RecentlyAddedPlaces(
                  cardHeight: 220,
                  sectionHeader: tr('recently_added'),
                  onHeaderClick: () {},
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadData() {
    context.read<FeaturedBloc>().fetchData();
    context.read<PopularPlacesBloc>().fetchData(_locale);
    context.read<RecentlyAddedPlacesBloc>().fetchData(_locale);
  }

  void _refreshData() {
    context.read<FeaturedBloc>().onRefresh();
    context.read<PopularPlacesBloc>().onRefresh(_locale);
    context.read<RecentlyAddedPlacesBloc>().onRefresh(_locale);
  }
}
