import 'package:dashboard/classes/corona_result.dart';
import 'package:dashboard/classes/stat-result.dart';
import 'package:dashboard/classes/time_series_count.dart';
import 'package:dashboard/utils/api_service.dart';
import 'package:dashboard/widgets/simple_time_seriesc_chart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'shop_items_page.dart';

class MainPage extends StatefulWidget {
  final Data coronaData;
  final bool isLoadingGovApi;
  MainPage({this.coronaData, this.isLoadingGovApi});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _messageText = "";

  bool isLoadStatApi = false;
  String updatedTime = '';

  List<TimeSeriesCount> _coronaDailyCases = new List<TimeSeriesCount>();
  List<TimeSeriesCount> _coronaDailyDeaths = new List<TimeSeriesCount>();
  List<TimeSeriesCount> _coronaDailyRecovers = new List<TimeSeriesCount>();

  @override
  void initState() {
    // call to get data from rest api
    _fetchCoronaStats();
    //_fetchCoronaCounts();

    _firebaseMessaging.subscribeToTopic('allUsers');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        //_fetchCoronaCounts();
        print("get notificaiton");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      print(token);
    });

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
                      Text('Sri Lanka Health Promotion Bureau - @$updatedTime',
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
                      widget.coronaData.localNewCases == null
                          ? 0.toString()
                          : widget.coronaData.localNewCases.toString(),
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
                      widget.coronaData.localNewDeaths == null
                          ? 0.toString()
                          : widget.coronaData.localNewDeaths.toString(),
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
                      Text('Total Cases',
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      Text(
                          widget.coronaData.localTotalCases == null
                              ? 0.toString()
                              : widget.coronaData.localTotalCases.toString(),
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

        _buildTile(
          Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: !this.isLoadStatApi
                    ? <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ]
                    : <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Grid Of Total Cases',
                                    style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 4.0)),
                        TimeSeriesPersonChart(_createCasesData())
                      ],
              )),
        ),

        //SizedBox(height: 20),
        // current active cases
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
                      Text('Current Active Cases',
                          style: TextStyle(
                              color: Colors.purple[800],
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      Text(
                          widget.coronaData.localActiveCases == null
                              ? 0.toString()
                              : widget.coronaData.localActiveCases.toString(),
                          style: TextStyle(
                              color: Colors.purple[800],
                              fontWeight: FontWeight.w900,
                              fontSize: 36.0))
                    ],
                  ),
                  Material(
                      color: Colors.purple[800],
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.airline_seat_flat_angled,
                            color: Colors.white, size: 30.0),
                      )))
                ]),
          ),
        ),

        //SizedBox(height: 20),

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
                      Text('Total Deaths',
                          style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      Text(
                          widget.coronaData.localDeaths == null
                              ? 0.toString()
                              : widget.coronaData.localDeaths.toString(),
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

        _buildTile(
          Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: !this.isLoadStatApi
                        ? <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ]
                        : <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Grid Of Total Deaths',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 4.0)),
                  TimeSeriesPersonChart(_createDeathsData())
                ],
              )),
        ),

        //SizedBox(height: 20),
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
                      Text('Total Recovered',
                          style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      Text(
                          widget.coronaData.localRecovered == null
                              ? 0.toString()
                              : widget.coronaData.localRecovered.toString(),
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

        _buildTile(
          Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: !this.isLoadStatApi
                        ? <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ]
                        : <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Grid Of Total Recovers',
                                    style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 4.0)),
                  TimeSeriesPersonChart(_createRecoversData())
                ],
              )),
        ),

        //SizedBox(height: 20),
        // total Individuals In Hospitals
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
                      Text('Total Individuals In Hospitals',
                          style: TextStyle(
                              color: Colors.yellow[800],
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      Text(
                          this
                                      .widget
                                      .coronaData
                                      .localTotalNumberOfIndividualsInHospitals ==
                                  null
                              ? 0.toString()
                              : this
                                  .widget
                                  .coronaData
                                  .localTotalNumberOfIndividualsInHospitals
                                  .toString(),
                          style: TextStyle(
                              color: Colors.yellow[800],
                              fontWeight: FontWeight.w900,
                              fontSize: 36.0))
                    ],
                  ),
                  Material(
                      color: Colors.yellow[800],
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.airline_seat_individual_suite,
                            color: Colors.white, size: 30.0),
                      )))
                ]),
          ),
        ),

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
                      Text('Shop Items',
                          style: TextStyle(color: Colors.redAccent)),
                      Text('173',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 34.0))
                    ],
                  ),
                  Material(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child:
                            Icon(Icons.store, color: Colors.white, size: 30.0),
                      )))
                ]),
          ),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => ShopItemsPage())),
        )
      ],
      staggeredTiles: [
        StaggeredTile.extent(2, 40.0),
        StaggeredTile.extent(1, 200.0),
        StaggeredTile.extent(1, 200.0),
        StaggeredTile.extent(2, 150.0),
        StaggeredTile.extent(2, 250.0),
        StaggeredTile.extent(2, 150.0),
        StaggeredTile.extent(2, 150.0),
        StaggeredTile.extent(2, 250.0),
        StaggeredTile.extent(2, 150.0),
        StaggeredTile.extent(2, 250.0),
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

  void _fetchCoronaStats() {
    setState(() {
      this.isLoadStatApi = false;
    });

    new ApiService().fetchCoronaStat().then((List<Records> value) {
      List<TimeSeriesCount> casesdata = new List<TimeSeriesCount>();
      List<TimeSeriesCount> deathsdata = new List<TimeSeriesCount>();
      List<TimeSeriesCount> recoversdata = new List<TimeSeriesCount>();

      if (value != null) {
        value.forEach((daily) {
          casesdata.add(new TimeSeriesCount(
              DateTime.parse(daily.recordDate), daily.casesCount));

          deathsdata.add(new TimeSeriesCount(
              DateTime.parse(daily.recordDate), daily.deathCount));

          recoversdata.add(new TimeSeriesCount(
              DateTime.parse(daily.recordDate), daily.recoverCount));
        });

        setState(() {
          this._coronaDailyCases = casesdata;
          this._coronaDailyDeaths = deathsdata;
          this._coronaDailyRecovers = recoversdata;
          this.isLoadStatApi = true;
        });
      }
    });
  }

  void printString() {
    print("hello world");
  }

  List<charts.Series<TimeSeriesCount, DateTime>> _createCasesData() {
    return [
      new charts.Series<TimeSeriesCount, DateTime>(
        id: 'Corona Cases',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesCount cases, _) => cases.time,
        measureFn: (TimeSeriesCount cases, _) => cases.count,
        data: this._coronaDailyCases,
      )
    ];
  }

  List<charts.Series<TimeSeriesCount, DateTime>> _createDeathsData() {
    return [
      new charts.Series<TimeSeriesCount, DateTime>(
        id: 'Corona_Deaths',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesCount cases, _) => cases.time,
        measureFn: (TimeSeriesCount cases, _) => cases.count,
        data: this._coronaDailyDeaths,
      )
    ];
  }

  List<charts.Series<TimeSeriesCount, DateTime>> _createRecoversData() {
    return [
      new charts.Series<TimeSeriesCount, DateTime>(
        id: 'Corona_Recovers',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesCount cases, _) => cases.time,
        measureFn: (TimeSeriesCount cases, _) => cases.count,
        data: this._coronaDailyRecovers,
      )
    ];
  }
}
