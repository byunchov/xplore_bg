import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/recent_places_bloc.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/widgets/place_item_small.dart';

class RecentlyAddedPlaces extends StatelessWidget {
  final double cardHeight;
  final String sectionHeader;
  final Function onHeaderClick;

  const RecentlyAddedPlaces({
    Key key,
    this.cardHeight = 250,
    @required this.sectionHeader,
    @required this.onHeaderClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<RecentlyAddedPlacesBloc>();
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    this.sectionHeader,
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
                    onPressed: this.onHeaderClick,
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              height: this.cardHeight,
              width: MediaQuery.of(context).size.width,
              // color: Colors.lightBlue,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: bloc.data.isEmpty ? 5 : bloc.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (bloc.data.isEmpty)
                    return SmallLoadingCard(
                        width: MediaQuery.of(context).size.width * 0.42);
                  return PlaceItemSmall(
                    tag: "recent",
                    place: bloc.data[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 2);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
