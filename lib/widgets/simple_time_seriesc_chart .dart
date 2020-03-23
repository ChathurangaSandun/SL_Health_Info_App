import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class TimeSeriesPersonChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate = true;

  TimeSeriesPersonChart(this.seriesList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: new charts.TimeSeriesChart(
        seriesList,
        animate: animate,

        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
        // should create the same type of [DateTime] as the data provided. If none
        // specified, the default creates local date time.
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      ),
    );
  }
}
