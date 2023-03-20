import 'package:flutter/material.dart';

class DatabaseModel {
  int? id;
  String title;
  int amount;

  DatabaseModel({required this.title, required this.amount, this.id});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
    };
  }
}
