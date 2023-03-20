import 'package:flutter/foundation.dart';

class KharchaTransaction {
  int? id;
  // String dateId;
  String title;
  int amount;
  DateTime? date;

  KharchaTransaction({
    this.id,
    // required this.dateId,
    required this.title,
    required this.amount,
     this.date,
  });

  KharchaTransaction copyWith({
    // String? dateId,
    String? title,
    int? amount,
    DateTime? date,
  }) {
    return KharchaTransaction(
      // dateId: dateId ?? this.dateId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
