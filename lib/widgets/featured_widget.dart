import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/feautured_bloc.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/widgets/home/editor_choice.dart';

class FeaturedPlaces extends StatefulWidget {
  final int initialPosition;

  const FeaturedPlaces({Key key, this.initialPosition = 1}) : super(key: key);
  @override
  _FeaturedPlacesState createState() => _FeaturedPlacesState();
}

class _FeaturedPlacesState extends State<FeaturedPlaces> {
  @override
  Widget build(BuildContext context) {
    Provider.of<FeaturedBloc>(context).locale = context.locale.toString();
    final featuredBloc = context.watch<FeaturedBloc>();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'feautured_places',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ).tr(),
              // SizedBox(height: 50),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 260,
          child: featuredBloc.data.isEmpty
              ? FeaturedLoadingCard()
              : Swiper(
                  itemCount: featuredBloc.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EditorsChoice(
                      place: featuredBloc.data[index],
                    );
                  },
                  loop: false,
                  viewportFraction: 1.0,
                  scale: 0.8,
                ),
        ),
      ],
    );
  }
}
