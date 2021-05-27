import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg/pages/bookmarks.dart';
import 'package:xplore_bg/pages/explore.dart';
import 'package:xplore_bg/pages/landmarks.dart';
import 'package:xplore_bg/pages/profile.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _selectedIndex;
  PageController _pageController;

  List<GButton> tabs = [];
  List<Color> colors = [
    Colors.purple,
    Colors.pink,
    Colors.amber[600],
    Colors.cyan[700],
    Colors.lightBlue
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      // body: AnimatedContainer(
      //   duration: Duration(milliseconds: 800),
      //   color: colors[selectedIndex],
      //   child: Center(child: _widgetOptions.elementAt(selectedIndex)),
      // ),
      body: PageView(
        controller: _pageController,
        // physics: NeverScrollableScrollPhysics(),
        physics: NeverScrollableScrollPhysics(),
        children: [
          ExplorePage(),
          // StatesPage(),
          LandmarksPage(),
          BookmarksPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Theme.of(context).primaryColor.withOpacity(0.8),
              iconSize: 25,
              // textStyle: TextStyle(
              //   fontSize: 15,
              // ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: Duration(milliseconds: 500),
              tabBackgroundColor:
                  Theme.of(context).primaryColor.withOpacity(0.15),
              tabs: [
                GButton(
                  icon: Feather.home,
                  // iconActiveColor: colors[selectedIndex],
                  // textColor: colors[selectedIndex],
                  // backgroundColor: colors[selectedIndex].withOpacity(.2),
                  text: 'menu_home'.tr(),
                ),
                GButton(
                  icon: Feather.compass,
                  text: 'menu_landmarks'.tr(),
                ),
                GButton(
                  icon: Feather.bookmark,
                  text: 'menu_bookmarks'.tr(),
                ),
                GButton(
                  icon: Feather.user,
                  text: 'menu_user_profile'.tr(),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                _pageController.animateToPage(index,
                    curve: Curves.easeInQuad,
                    duration: Duration(milliseconds: 400));
              },
            ),
          ),
        ),
      ),
    );
  }
}
