import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:line_icons/line_icons.dart';

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
                ListTile(
                  title: Text("byunchov@gmail.com"),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.at_sign,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                ),
                Divider(height: 5),
                ListTile(
                  title: Text("Редакция на профил"),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.edit,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                ),
                Divider(height: 5),
                ListTile(
                  title: Text("Изход"),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.log_out,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                ),
                SizedBox(height: 20),
                Text(
                  "General settings",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text("Връзка с нас"),
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
                  title: Text("Език"),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
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
                ),
                Divider(height: 5),
                ListTile(
                  title: Text("За нас"),
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
  const UserProfileUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 165,
            // color: Colors.cyan[700],
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.cyan[200],
                Colors.cyan[500],
                Colors.cyan[700],
              ],
            )),
          ),
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 20, right: 20, top: 85),
            // color: Colors.blue,
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
              padding: EdgeInsets.only(top: 25),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 35),
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey[400],
                backgroundImage:
                    AssetImage("assets/images/categories/mountain.jpg"),
              ),
            ),
          ),
          Positioned(
            left: 25,
            right: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width / 2 - 65 - 20),
            top: 110,
            child: Column(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Positioned(
            right: 25,
            left: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width / 2 - 65 - 20),
            top: 110,
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Text(
                "Bozhidar Yunchov",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
