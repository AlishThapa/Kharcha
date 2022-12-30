import 'package:flutter/material.dart';
import 'package:kharcha_book/widgets/New_transaction.dart';
import 'package:kharcha_book/widgets/chart.dart';
import 'package:kharcha_book/widgets/transaction_list.dart';
import 'kharcha.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Kharcha Book',
      home: Myhomepage(),
    );
  }
}

class Myhomepage extends StatefulWidget {
  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime choosenDate) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: choosenDate,
      id:  DateTime.now().toString(),
    );
    setState(
      () {
        _userTransactions.add(newTransaction);
      },
    );
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _proceedToNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final AppBar appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _proceedToNewTransaction(context),
        ),
      ],
    );

    final double _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _height * 0.3,
              child: Chart(recentTransactions: _recentTransactions),
            ),
            Container(
              height: _height * 0.7,
              child: TransactionList(_userTransactions, _deleteTx),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () => _proceedToNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
