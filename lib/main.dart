import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/pages/country_states.dart';
import 'package:xplore_bg/pages/explore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.cyan[700],
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();

  List<GButton> tabs = new List();
  List<Color> colors = [
    Colors.purple,
    Colors.pink,
    Colors.amber[600],
    Colors.cyan[700],
    Colors.lightBlue
  ];

  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Начало',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Области',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Отметки',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Профил',
  //     style: optionStyle,
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
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
        physics: NeverScrollableScrollPhysics(),
        children: [
          ExplorePage(),
          StatesPage(),
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
                activeColor: Colors.cyan[700],
                iconSize: 28,
                // textStyle: TextStyle(
                //   fontSize: 15,
                // ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: Colors.cyan[700].withOpacity(0.15),
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    // iconActiveColor: colors[selectedIndex],
                    // textColor: colors[selectedIndex],
                    // backgroundColor: colors[selectedIndex].withOpacity(.2),
                    text: 'Начало',
                  ),
                  GButton(
                    icon: LineIcons.list_ul,
                    // iconActiveColor: colors[selectedIndex],
                    // textColor: colors[selectedIndex],
                    // backgroundColor: colors[selectedIndex].withOpacity(.2),
                    text: 'Области',
                  ),
                  GButton(
                    icon: LineIcons.bookmark_o,
                    // iconActiveColor: colors[selectedIndex],
                    // textColor: colors[selectedIndex],
                    // backgroundColor: colors[selectedIndex].withOpacity(.2),
                    text: 'Отметки',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    // iconActiveColor: colors[selectedIndex],
                    // textColor: colors[selectedIndex],
                    // backgroundColor: colors[selectedIndex].withOpacity(.2),
                    text: 'Профил',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  _pageController.animateToPage(index,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 400));
                }),
          ),
        ),
      ),
    );
  }
}
