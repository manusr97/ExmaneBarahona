import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:dogs_db_pseb_bridge/models/dog.dart';

import '../db/controlador.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Graph(),
    );
  }
}

class Graph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Graph({Key? key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafico'),
      ),
      body: FutureBuilder<List<Bitcoin>>(
        future: DatabaseHelper.instance.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<List<Bitcoin>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No Dogs Found in Database'));
            } else {
              List<Bitcoin> dogs = snapshot.data!;
              return Column(children: [
                //Initialize the chart widget
                SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'Cantidad BTC comprados'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<Bitcoin, String>>[
                      LineSeries<Bitcoin, String>(
                          dataSource: dogs,
                          xValueMapper: (Bitcoin sales, _) => sales.fecha,
                          yValueMapper: (Bitcoin sales, _) => sales.qtyBuy,
                          name: 'BTC',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    //Initialize the spark charts widget
                    child: SfSparkLineChart.custom(
                      //Enable the trackball
                      trackball: const SparkChartTrackball(
                          activationMode: SparkChartActivationMode.tap),
                      //Enable marker
                      marker: const SparkChartMarker(
                          displayMode: SparkChartMarkerDisplayMode.all),
                      //Enable data label
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      xValueMapper: (int index) => dogs[index].fecha,
                      yValueMapper: (int index) => dogs[index].qtyBuy,
                      dataCount: 1,
                    ),
                  ),
                )
              ]);
            };
          };
        },
      ),
    );
  }
}

// class SalesData {
//   SalesData(listaPerro);
//
//   final listaPerro = DatabaseHelper.instance.getAllDogs();
//
//
// }
