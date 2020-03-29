import 'package:dashboard/classes/corona_result.dart';
import 'package:dashboard/pages/main_page.dart';
import 'package:dashboard/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/widgets/bar-item.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
    bool _isLoadingGovApi = false;
    Data  coronaData = Data();
  List<Widget> _children() => [MainPage(coronaData:coronaData,isLoadingGovApi: _isLoadingGovApi,), Text("Teb 2")];

  @override
  void initState() {
    _fetchCoronaCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Info',
        child: Icon(Icons.info_outline),
        elevation: 7.0,
      ),
      body: _children()[_currentIndex],
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
  void _fetchCoronaCounts() {
    setState(() {
      _isLoadingGovApi = false;
    });
    new ApiService().fetchCoronaData().then((Data value) {
      setState(() {
        this.coronaData = value;        
        this._isLoadingGovApi = true;
      });
    });
  }
}
