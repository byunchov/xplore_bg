import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/widgets/header.dart';
import 'package:xplore_bg/widgets/place_item_small.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          "Най-популярни",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800],
                          ),
                        ),
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        PlaceItemSmall(
                          tag: "popular",
                          place: Place(
                            name: "Банско",
                            loves: 100,
                            gallery: <String>[
                              "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
                            ],
                          ),
                        ),
                        PlaceItemSmall(
                          tag: "popular",
                          place: Place(
                            name: "Разлог",
                            loves: 89,
                            gallery: <String>[
                              "http://infomreja.bg/upload/articles/images/18387/024ec2c710680539c9257aa4a27fd7d5.jpg",
                            ],
                          ),
                        ),
                        PlaceItemSmall(
                          tag: "popular",
                          place: Place(
                            name: "Добринище",
                            loves: 54,
                            gallery: <String>[
                              "https://visit-dobrinishte.bg/images/slider/sl1.jpg",
                            ],
                          ),
                        ),
                        PlaceItemSmall(
                          tag: "popular",
                          place: Place(
                            name: "Баня",
                            loves: 61,
                            gallery: <String>[
                              "https://rimskabania.com/wp-content/uploads/2016/03/Old_Roman_01.jpg",
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
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
                          "Наскоро добавени",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        PlaceItemSmall(
                          tag: "recent",
                          place: Place(
                            name: "Банско",
                            loves: 100,
                            gallery: <String>[
                              "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
                            ],
                          ),
                        ),
                        PlaceItemSmall(
                          tag: "recent",
                          place: Place(
                            name: "Разлог",
                            loves: 89,
                            gallery: <String>[
                              "http://infomreja.bg/upload/articles/images/18387/024ec2c710680539c9257aa4a27fd7d5.jpg",
                            ],
                          ),
                        ),
                        PlaceItemSmall(
                          tag: "recent",
                          place: Place(
                            name: "Добринище",
                            loves: 54,
                            gallery: <String>[
                              "https://visit-dobrinishte.bg/images/slider/sl1.jpg",
                            ],
                          ),
                        ),
                        PlaceItemSmall(
                          tag: "recent",
                          place: Place(
                            name: "Баня",
                            loves: 61,
                            gallery: <String>[
                              "https://rimskabania.com/wp-content/uploads/2016/03/Old_Roman_01.jpg",
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
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
