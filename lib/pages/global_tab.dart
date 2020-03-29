import 'package:dashboard/classes/corona_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GlobalTab extends StatefulWidget {
  final Data coronaData;
  GlobalTab({this.coronaData});

  @override
  _GlobalTabState createState() => _GlobalTabState();
}

class _GlobalTabState extends State<GlobalTab> {  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StaggeredGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
      children: <Widget>[
        // time
        _buildTile(
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Sri Lanka Health Promotion Bureau - @'+ widget.coronaData.updateDateTime,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0)),
                    ],
                  ),
                ]),
          ),
        ),
        //SizedBox(height: 20),
        // new cases
        _buildTile(
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Material(
                      color: Colors.blue[600],
                      shape: CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.local_hospital,
                            color: Colors.white, size: 24.0),
                      )),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('New Cases',
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0)),
                  Text(
                      widget.coronaData.globalNewCases == null
                          ? 0.toString()
                          : widget.coronaData.globalNewCases.toString(),
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w900,
                          fontSize: 36.0))
                ]),
          ),
        ),

        // new deths
        _buildTile(
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Material(
                      color: Colors.red[600],
                      shape: CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.airline_seat_flat,
                            color: Colors.white, size: 24.0),
                      )),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('New Deaths',
                      style: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0)),
                  Text(
                      widget.coronaData.globalNewDeaths == null
                          ? 0.toString()
                          : widget.coronaData.globalNewDeaths.toString(),
                      style: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.w900,
                          fontSize: 36.0))
                ]),
          ),
        ),
        //SizedBox(height: 20),

        // total cases
        _buildTile(
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Global Total Cases',
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      Text(
                          widget.coronaData.globalTotalCases == null
                              ? 0.toString()
                              : widget.coronaData.globalTotalCases.toString(),
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w900,
                              fontSize: 36.0))
                    ],
                  ),
                  Material(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.local_hospital,
                            color: Colors.white, size: 30.0),
                      )))
                ]),
          ),
        ),

        // total deths
        _buildTile(
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Global Total Deaths',
                          style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      Text(
                          widget.coronaData.globalDeaths == null
                              ? 0.toString()
                              : widget.coronaData.globalDeaths.toString(),
                          style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.w900,
                              fontSize: 36.0))
                    ],
                  ),
                  Material(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.airline_seat_flat,
                            color: Colors.white, size: 30.0),
                      )))
                ]),
          ),
        ),

        // total recovered
        _buildTile(
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Global Total Recovered',
                          style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      Text(
                          widget.coronaData.globalRecovered == null
                              ? 0.toString()
                              : widget.coronaData.globalRecovered.toString(),
                          style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w900,
                              fontSize: 36.0))
                    ],
                  ),
                  Material(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.accessibility_new,
                            color: Colors.white, size: 30.0),
                      )))
                ]),
          ),
        ),
      ],
      staggeredTiles: [
        StaggeredTile.extent(2, 40.0),
        StaggeredTile.extent(1, 200.0),
        StaggeredTile.extent(1, 200.0),
        StaggeredTile.extent(2, 150.0),
        StaggeredTile.extent(2, 150.0),
        StaggeredTile.extent(2, 150.0),
      ],
    ));
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(4.0),
        //shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
