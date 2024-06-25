import 'package:flutter/material.dart';
import '../../../model/gdb_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialBar extends StatelessWidget {
  const RadialBar({
    required this.percentage,
    super.key,
  });
  final int percentage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.22,
      width: MediaQuery.sizeOf(context).width * 0.33,
      child: SfCircularChart(
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            //* The text to be displayed in the center of the chart
            widget: Text(
              '$percentage%',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.sizeOf(context).height * 0.025,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        //*colors of the chart
        palette: [
          Colors.teal.shade400,
        ],
        //*the name of the chart
        legend: const Legend(
            isResponsive: true,
            alignment: ChartAlignment.center,
            position: LegendPosition.bottom,
            offset: Offset.zero,
            padding: 5,
            isVisible: true,
            overflowMode: LegendItemOverflowMode.none),
        //* the title on pressed the chart
        tooltipBehavior: TooltipBehavior(
          enable: true,
          borderWidth: 5,
          borderColor: Colors.teal,
          color: Colors.white,
          textStyle: const TextStyle(color: Colors.black),
        ),
        //* chart characteristics
        series: <CircularSeries>[
          RadialBarSeries<GDBdata, String>(
            dataSource: getChartData(percentage),
            xValueMapper: (GDBdata data, index) => data.content,
            yValueMapper: (GDBdata data, index) => data.gdp,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
            enableTooltip: true,
            maximumValue: 105,
            useSeriesColor: true,
            trackOpacity: 0.3,
            cornerStyle: CornerStyle.endCurve,
            radius: '90%',
            innerRadius: '80%',
          ),
        ],
      ),
    );
  }
}
