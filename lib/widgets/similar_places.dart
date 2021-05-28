import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/similar_places_bloc.dart';
import 'package:xplore_bg/pages/blank_page.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/widgets/place_item_small.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class SimilarPlaces extends StatefulWidget {
  final String category;
  final String placeId;
  const SimilarPlaces({
    Key key,
    @required this.category,
    @required this.placeId,
  }) : super(key: key);

  @override
  _SimilarPlacesState createState() => _SimilarPlacesState();
}

class _SimilarPlacesState extends State<SimilarPlaces> {
  String _locale;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      context
          .read<SimilarPlacesBloc>()
          .fetchData(widget.placeId, widget.category, _locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    _locale = context.locale.toString();
    final bloc = context.watch<SimilarPlacesBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Може да харесате",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        CustomDivider(
          width: 120,
          height: 3,
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
        Container(
          height: 230,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: bloc.data.isEmpty ? 5 : bloc.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (bloc.data.isEmpty) {
                return SmallLoadingCard(
                    width: MediaQuery.of(context).size.width * 0.42);
              } else if (bloc.data == null) {
                return BlankPage(
                  heading: "Nothing found",
                );
              }
              return PlaceItemSmall(
                place: bloc.data[index],
                tag: "similar${UniqueKey().toString()}${widget.placeId}",
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 2);
            },
          ),
        ),
      ],
    );
  }
}
