import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/feautured_bloc.dart';
import 'package:xplore_bg/pages/explore.dart';

class FeaturedPlaces extends StatefulWidget {
  @override
  _FeaturedPlacesState createState() => _FeaturedPlacesState();
}

class _FeaturedPlacesState extends State<FeaturedPlaces> {
  @override
  Widget build(BuildContext context) {
    Provider.of<FeaturedBloc>(context).locale = context.locale.toString();
    final featuredBloc = context.watch<FeaturedBloc>();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 260,
      child: featuredBloc.data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Swiper(
              itemCount: featuredBloc.data.length,
              itemBuilder: (BuildContext context, int index) {
                print(
                    "${featuredBloc.data[index].latitude}|${featuredBloc.data[index].longitude}");
                return EditorsChoice(
                  place: featuredBloc.data[index],
                );
              },
              loop: false,
              viewportFraction: 1.0,
              scale: 0.8,
              // pagination: SwiperPagination(),
            ),
    );
  }
}
