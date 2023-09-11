// import 'dart:ffi';
import 'dart:ffi';
import 'dart:math';
import 'dart:convert';

import '../settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:simple_line_chart/simple_line_chart.dart';

class LineChartContent extends StatefulWidget {
  const LineChartContent({super.key, required this.controller});

  static const routeName = '/line_chart';

  final SettingsController controller;

  @override
  State<StatefulWidget> createState() {
    return _LineChartContentState(controller: controller);
  }
}

class _LineChartContentState extends State<LineChartContent> {
  _LineChartContentState({required this.controller});
  //_LineChartContentState();

  //static const routeName = '/line_chart';

  final SettingsController controller;
  int degrees = 10;
  late LineChartData data;

  @override
  void initState() {
    super.initState();

    // create a data model
    degrees = 10;
    data = LineChartData(datasets: [
      Dataset(
          label: 'First',
          dataPoints: _createDataPoints(offsetInDegrees: degrees)),
      // Dataset(
      //     label: 'Second', dataPoints: _createDataPoints(offsetInDegrees: 80)),
      // Dataset(
      //     label: 'Third', dataPoints: _createDataPoints(offsetInDegrees: 180))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    linechartUpdate();
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 20),
          child: LineChart(
              // chart is styled
              style: LineChartStyle.fromTheme(context),
              seriesHeight: 200,

              // chart has data
              data: data))
    ]);
  }

  void linechartUpdate() {
    debugPrint("linechartUpdate");
    String newdata = controller.dataString;
    //String newdata = "swv=[[100.1,200.1,300.3,400.4,100.1,200.1,300.3,400.4]]";

    List<dynamic> list = json.decode(newdata.substring(5, newdata.length - 1));

    // List<String> newDataList = newdata.split(',');
    List<DataPoint> dataPoints = [];
    for (int i = 0; i < (list.length / 2); i++) {
      double xvar =
          i.toDouble() * controller.es + controller.range.start.round();
      double yvar = list[i * 2] * (-1.0) + list[i * 2 + 1] * 1.0;
      //debugPrint('$yvar \r\n'); //  + '\r\n');
      //print(float(newDataList[i].) + '\r\n');
      dataPoints.add(DataPoint(x: xvar, y: yvar));
    }

    data = LineChartData(datasets: [
      Dataset(label: 'SWV', dataPoints: dataPoints),
      // Dataset(
      //     label: 'Second', dataPoints: _createDataPoints(offsetInDegrees: 80)),
      // Dataset(
      //     label: 'Third', dataPoints: _createDataPoints(offsetInDegrees: 180))
    ]);
  }
}

// data points are created on a sine curve here,
// but you can plot any data you like
List<DataPoint> _createDataPoints({required int offsetInDegrees}) {
  List<DataPoint> dataPoints = [];
  const degreesToRadians = (pi / 180);
  for (int x = 0; x < 180; x += 5) {
    final di = (x * 2).toDouble() * degreesToRadians;
    dataPoints.add(DataPoint(
        x: x.toDouble(), y: 100.0 * ((sin(di + offsetInDegrees) + 1.0) / 2.0)));
  }
  return dataPoints;
}
