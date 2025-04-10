import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

class YearlyChart extends StatefulWidget {
  YearlyChart({super.key, required this.revenueList});

  final revenueList;
  final Color barBackgroundColor = Colors.grey;
  final Color barColor = Colors.red;
  final Color touchedBarColor = Colors.red;

  @override
  State<StatefulWidget> createState() => YearlyChartState();
}

class YearlyChartState extends State<YearlyChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Yearly Chart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            40.ph,
            Expanded(child: BarChart(mainBarData(), duration: animDuration)),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: 15,
          backDrawRodData: BackgroundBarChartRodData(
            show: false,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, widget.revenueList[0].toDouble());
      case 1:
        return makeGroupData(1, widget.revenueList[1].toDouble());
      case 2:
        return makeGroupData(2, widget.revenueList[2].toDouble());
      case 3:
        return makeGroupData(3, widget.revenueList[3].toDouble());
      case 4:
        return makeGroupData(4, widget.revenueList[4].toDouble());
      case 5:
        return makeGroupData(5, widget.revenueList[5].toDouble());
      case 6:
        return makeGroupData(6, widget.revenueList[6].toDouble());
      case 7:
        return makeGroupData(7, widget.revenueList[7].toDouble());
      case 8:
        return makeGroupData(8, widget.revenueList[8].toDouble());
      case 9:
        return makeGroupData(9, widget.revenueList[9].toDouble());
      case 10:
        return makeGroupData(10, widget.revenueList[10].toDouble());
      case 11:
        return makeGroupData(11, widget.revenueList[11].toDouble());
      default:
        return throw Error();
    }
  });

  BarChartData mainBarData() {
    return BarChartData(
      minY: 0,
      maxY: 160000,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => context.colorScheme.secondary,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: 10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String month;
            switch (group.x) {
              case 0:
                month = 'jan';
                break;
              case 1:
                month = 'feb';
                break;
              case 2:
                month = 'mar';
                break;
              case 3:
                month = 'apr';
                break;
              case 4:
                month = 'may';
                break;
              case 5:
                month = 'jun';
                break;
              case 6:
                month = 'july';
                break;
              case 7:
                month = 'aug';
                break;
              case 8:
                month = 'sep';
                break;
              case 9:
                month = 'oct';
                break;
              case 10:
                month = 'nov';
                break;
              case 11:
                month = 'dec';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$month\n',
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              children: <TextSpan>[
                TextSpan(
                  text:
                      // "${((rod.toY / 1000)).toString()}K",
                      "${(rod.toY / 1000) % 1 == 0 ?
                      (rod.toY / 1000).toInt() : (rod.toY / 1000)}K",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false, reservedSize: 70),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 45,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Jan', style: style);
        break;
      case 1:
        text = Text('Feb', style: style);
        break;
      case 2:
        text = Text('Mar', style: style);
        break;
      case 3:
        text = Text('Apr', style: style);
        break;
      case 4:
        text = Text('May', style: style);
        break;
      case 5:
        text = Text('Jun', style: style);
        break;
      case 6:
        text = Text('Jul', style: style);
        break;
      case 7:
        text = Text('Aug', style: style);
        break;
      case 8:
        text = Text('Sep', style: style);
        break;
      case 9:
        text = Text('Oct', style: style);
        break;
      case 10:
        text = Text('Nov', style: style);
        break;
      case 11:
        text = Text('Dec', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(meta: meta, space: 15, child: text);
  }
}
