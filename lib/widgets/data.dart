import 'package:flutter/material.dart';
import 'chart_bar.dart';

class Data extends StatelessWidget {
  const Data({Key key, @required this.maxSpend, @required this.data})
      : super(key: key);

  final double maxSpend;
  final data;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: ChartBar(
        label:data['day'] ,
        spendingAmount: data['amount'],
        spendingPercentageOfTotal:maxSpend == 0.0 ? 0.0 : (data['amount'] as double) / maxSpend,

      ),
    );
  }
}