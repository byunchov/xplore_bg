import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';

class ImageCarousel extends StatelessWidget {
  final double heigth;
  final List<dynamic> imgList;
  final bool autoPlay;
  final String tag;

  const ImageCarousel({
    Key key,
    @required this.imgList,
    this.heigth = 320,
    this.autoPlay = false,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.heigth,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return CustomCachedImage(
            imageUrl: imgList[index],
            fit: BoxFit.fill,
          );
        },
        autoplay: this.autoPlay,
        itemCount: imgList.length,
        pagination: SwiperPagination(
          alignment: Alignment.bottomLeft,
          builder: SwiperCustomPagination(builder: (context, config) {
            return ConstrainedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black.withOpacity(0.55),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Author ${config.activeIndex}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.8),
                        ),
                        child: FractionPaginationBuilder(
                                color: Colors.white70,
                                activeColor: Colors.white,
                                fontSize: 17.0,
                                activeFontSize: 22.0)
                            .build(context, config),
                      ),
                    ),
                  )
                ],
              ),
              constraints: BoxConstraints.expand(height: 50.0),
            );
          }),
        ),
      ),
    );
  }
}