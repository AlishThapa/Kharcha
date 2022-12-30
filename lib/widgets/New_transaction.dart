import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _date;

  void _dataSubmission() {
    final isTitleEntered = _titleController.text;
    final isAmountEntered = double.parse(
        _amountController.text); //  it will convert string to double

    if (isTitleEntered.isEmpty || isAmountEntered <= 0 || _date == null) {
      return;
    }
    widget.addTransaction(
      isTitleEntered,
      isAmountEntered,
      _date,
    );

    Navigator.of(context).pop();
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
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.green),
              ),
              controller: _titleController,
              onSubmitted: (_) => _dataSubmission(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.green),
              ),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              onSubmitted: (_) => _dataSubmission(),
            ),
            Container(
              height: 100,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _date == null
                              ? 'No Date Chosen!'
                              : 'Chosen Date: ${DateFormat.yMd().format(_date)}',
                        ),
                      ),
                      OutlinedButton(
                        onPressed: _presentDatePicker,
                        child: Text('Choose Date'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent),
                    onPressed: () {
                      _dataSubmission();
                    },
                    child: Text('Add your kharcha'),
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
