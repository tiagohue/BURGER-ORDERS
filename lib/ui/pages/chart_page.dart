import 'package:burger_orders/data/models/order.dart';
import 'package:burger_orders/data/repositories/order_repository.dart';
import 'package:burger_orders/ui/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    final orderRepo = context.watch<OrderRepository>();

    final orders = orderRepo.orders;

    Map<String, int> quantityPerDate = {};
    for (Order o in orders) {
      if (!quantityPerDate.keys.contains(o.date)) {
        quantityPerDate[o.date] = 1;
      } else {
        quantityPerDate[o.date] = (quantityPerDate[o.date] ?? 0) + 1;
      }
    }

    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < quantityPerDate.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: quantityPerDate.values.elementAt(i).toDouble(),
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.zero,
              width: 15,
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(child: Text("Chart")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: barGroups.isNotEmpty
              ? BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: 20,
                    barGroups: barGroups,
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            String date = quantityPerDate.keys.elementAt(
                              value.toInt(),
                            );
                            return SideTitleWidget(
                              meta: meta,
                              child: Text(Utils.formatDate(date)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : Center(child: Text("Loading or You dont have data!")),
        ),
      ),
    );
  }
}
