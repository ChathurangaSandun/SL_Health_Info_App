import 'package:dashboard/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/classes/bar-item.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [MainPage(), Text("Teb 2")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("SL Health Info"),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Info',
        child: Icon(Icons.info_outline),
        elevation: 7.0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _selectedTab,
        notchedShape: CircularNotchedRectangle(),
        selectedColor: Colors.grey,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Local'),
          FABBottomAppBarItem(iconData: Icons.language, text: 'Global'),
        ],
      ),
    );
  }

  void _selectedTab(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
