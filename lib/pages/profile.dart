import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/utils/language_select.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _tileIconSize = 30;

    return Scaffold(
      appBar: AppBar(
        title: Text('menu_user_profile').tr(),
        actions: [
          IconButton(
            icon: Icon(Feather.log_out),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          UserProfileUI(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ListTile(
                //   title: Text("byunchov@gmail.com"),
                //   leading: Container(
                //     height: _tileIconSize,
                //     width: _tileIconSize,
                //     decoration: BoxDecoration(
                //       color: Colors.blueAccent,
                //       borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                //     ),
                //     child: Icon(
                //       LineIcons.at,
                //       size: _tileIconSize * 0.65,
                //       color: Colors.white,
                //     ),
                //   ),
                //   trailing:
                //       Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                // ),
                // Divider(height: 5),
                // ListTile(
                //   title: Text("edit_profile").tr(),
                //   leading: Container(
                //     height: _tileIconSize,
                //     width: _tileIconSize,
                //     decoration: BoxDecoration(
                //       color: Colors.orangeAccent,
                //       borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                //     ),
                //     child: Icon(
                //       Feather.edit,
                //       size: _tileIconSize * 0.65,
                //       color: Colors.white,
                //     ),
                //   ),
                //   trailing:
                //       Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                // ),
                // Divider(height: 5),
                // ListTile(
                //   title: Text("logout").tr(),
                //   leading: Container(
                //     height: _tileIconSize,
                //     width: _tileIconSize,
                //     decoration: BoxDecoration(
                //       color: Colors.redAccent,
                //       borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                //     ),
                //     child: Icon(
                //       Feather.log_out,
                //       size: _tileIconSize * 0.65,
                //       color: Colors.white,
                //     ),
                //   ),
                //   trailing:
                //       Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                // ),
                // SizedBox(height: 20),
                Text(
                  "general_settings",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
                SizedBox(height: 20),
                ListTile(
                  title: Text("select_lang").tr(),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.globe,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => SelectLanguagePage()));
                  },
                ),
                Divider(height: 5),
                ListTile(
                  title: Text("feedback").tr(),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.mail,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                ),
                Divider(height: 5),
                ListTile(
                  title: Text("about_app").tr(),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.info,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileUI extends StatelessWidget {
  final double height;
  final double avatarRadius;

  const UserProfileUI({
    Key key,
    this.height = 320,
    this.avatarRadius = 65,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                backgroundImage:
                    AssetImage("assets/images/categories/mountain.jpg"),
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
                        "800",
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
                        "235",
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
                    "Bozhidar Yunchov",
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
                    "byunchov@email.com",
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
                        onPressed: () {},
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
                        onPressed: () {},
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          )
          // Positioned(
          //   right: 25,
          //   left: MediaQuery.of(context).size.width -
          //       (MediaQuery.of(context).size.width / 2 - 65 - 20),
          //   top: 110,
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.bookmark,
          //         size: 30,
          //         color: Colors.cyan[700],
          //       ),
          //       SizedBox(height: 5),
          //       Text(
          //         "235",
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.w700,
          //           color: Colors.grey[700],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: paddingTop + paddingLRT + rDecoration + 25,
          //   child: Padding(
          //     padding: EdgeInsets.only(bottom: 25),
          //     child: Text(
          //       "Bozhidar Yunchov",
          //       textAlign: TextAlign.center,
          //       maxLines: 2,
          //       style: TextStyle(
          //         fontSize: 26,
          //         color: Colors.grey[800],
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
