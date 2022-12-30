import 'package:flutter/material.dart';
import 'package:kharcha_book/kharcha.dart';
import 'package:intl/intl.dart';
import 'data.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpend {
    return groupedTransactionValues.fold(
      0.0,
      (sum, item) => sum + item["amount"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map((data) => Data(data: data, maxSpend: maxSpend))
              .toList(),
        ),
      ),
    );
  }
}
