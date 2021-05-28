import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/pages/profile_edit.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/page_navigation.dart';

class UserProfileUI extends StatelessWidget {
  final double height;
  final double avatarRadius;
  final Function logoutCallback;

  const UserProfileUI({
    Key key,
    this.height = 320,
    this.avatarRadius = 65,
    @required this.logoutCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SigninBloc _signinBloc = context.watch<SigninBloc>();

    double decorationThickness = 10;
    double rDecoration = this.avatarRadius + decorationThickness;
    double paddingLRT = 20;
    double paddingTop = this.avatarRadius + paddingLRT;
    double screenWidth = MediaQuery.of(context).size.width;
    double iconStackWidth =
        (screenWidth - paddingLRT * 2) / 2 - this.avatarRadius;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.height,
      child: Stack(
        children: [
          Container(
            height: this.height * 0.66, //165
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Colors.cyan[200],
                // Theme.of(context).appBarTheme.color,
                Colors.cyan[200],
                Colors.cyan[500],
                Colors.cyan[700],
              ],
            )),
          ),
          Container(
            height: this.height,
            padding: EdgeInsets.only(
                left: paddingLRT, right: paddingLRT, top: paddingTop),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2.0,
                    blurRadius: 8.0,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: paddingLRT + 5),
              child: Container(
                width: rDecoration * 2,
                height: rDecoration * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rDecoration),
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  EdgeInsets.only(top: paddingLRT + decorationThickness + 5),
              child: CircleAvatar(
                radius: this.avatarRadius, //65
                backgroundColor: Colors.grey[400],
                backgroundImage: CachedNetworkImageProvider(
                    _signinBloc.imageUrl ?? AppConfig.defaultProfilePic),
              ),
            ),
          ),
          Positioned(
            left: paddingLRT, //25
            right: paddingLRT,
            top: paddingTop + paddingLRT + 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: iconStackWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.heart,
                        size: 30,
                        color: Colors.redAccent,
                      ),
                      SizedBox(height: 5),
                      Text(
                        _signinBloc.lovedCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: iconStackWidth,
                  child: Column(
                    children: [
                      Icon(
                        Icons.bookmark,
                        size: 30,
                        color: Colors.cyan[700],
                      ),
                      SizedBox(height: 5),
                      Text(
                        _signinBloc.bookmarksCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: paddingLRT + rDecoration * 2 + 25,
              ),
              child: Column(
                children: [
                  Text(
                    _signinBloc.name.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    _signinBloc.email.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Spacer(),
                      ElevatedButton.icon(
                        icon: Icon(
                          Feather.edit,
                          size: 18,
                        ),
                        label: Text(
                          'edit_profile',
                          style: TextStyle(fontSize: 15),
                        ).tr(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          nextScreenMaterial(
                            context,
                            EditProfile(
                              name: _signinBloc.name,
                              imageUrl: _signinBloc.imageUrl,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        icon: Icon(
                          Feather.log_out,
                          size: 18,
                        ),
                        label: Text(
                          'logout',
                          style: TextStyle(fontSize: 15),
                        ).tr(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: logoutCallback,
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
