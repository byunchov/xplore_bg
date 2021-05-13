import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/utils/place_list.dart';
import 'package:xplore_bg/widgets/header.dart';
import 'package:xplore_bg/widgets/place_item_small.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 20,
      //   title: const Text('Xplore Bulgaria'),
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "most_popular",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800],
                          ),
                        ).tr(),
                        IconButton(
                          icon: Icon(
                            Feather.arrow_right,
                            color: Colors.grey[800],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.lightBlue,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return PlaceItemSmall(
                          tag: "popular$index",
                          place: categoryContent[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 2);
                      },
                      itemCount: categoryContent.length,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'recently_added',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ).tr(),
                        IconButton(
                          icon: Icon(
                            Feather.arrow_right,
                            color: Colors.grey[800],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.lightBlue,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return PlaceItemSmall(
                          tag: "recent$index",
                          place: categoryContent[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 2);
                      },
                      itemCount: categoryContent.length,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
