import 'package:flutter/material.dart';

class FilteringPage extends StatefulWidget {
  @override
  _FilteringPageState createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  bool isExpandedFilter1;
  bool testCheckbox1;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    isExpandedFilter1 = true;
    testCheckbox1 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FIltering"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text("Child 1"),
            ],
          ),
        ),
      ),
    );
  }
}
