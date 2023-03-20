// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kharcha_book/db/database_service.dart';

import '../db/db_model/database_model.dart';
import '../screens/homepage/home_page.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _date;

  void _dataSubmission() {
    final isTitleEntered = _titleController.text;
    final isAmountEntered = int.parse(_amountController.text); //  it will convert string to double
    DatabaseService().create(
      DatabaseModel(
        title: _titleController.text,
        amount: int.parse(_amountController.text),

      ),
    );
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyHomePage(),));
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) return;
      setState(() {
        _date = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.green),
              ),
              controller: _titleController,
              onSubmitted: (_) => _dataSubmission(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.green),
              ),
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              onSubmitted: (_) => _dataSubmission(),
            ),
            SizedBox(
              height: 100,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _date == null ? 'No Date Chosen!' : 'Chosen Date: ${DateFormat.yMd().format(_date!)}',
                        ),
                      ),
                      OutlinedButton(
                        onPressed: _presentDatePicker,
                        child: const Text('Choose Date'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                    onPressed: () => _dataSubmission(),
                    child: const Text('Add your kharcha'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
