import 'package:flutter/material.dart';
import 'package:kharcha_book/db/database_service.dart';
import '../../models/kharcha.dart';
import '../../widgets/New_transaction.dart';
import '../../widgets/chart.dart';
import '../../widgets/transaction_list.dart';
import 'package:flutter/foundation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
   List<KharchaTransaction> _userTransactions = [];
   List<KharchaTransaction> _recentTransactions = [];

  void recentTransaction () {
    setState(() {
      _recentTransactions = _userTransactions.where((element) {
        return element.date!.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      }).toList();
    });
  }

  void getTransaction() async {
     List<KharchaTransaction>  userTransactions = await DatabaseService().readKharcha();
     setState(() {
       _userTransactions = userTransactions;
     });

  }

  void _addNewTransaction(String title, int amount, DateTime chosenDate) {
    final newTransaction = KharchaTransaction(
      title: title,
      amount: amount,
      date: chosenDate,
      // dateId: DateTime.now().toString(),
    );
    setState(
      () {
        _userTransactions.add(newTransaction);
      },
    );
  }

  void _deleteTx(int id) {
    DatabaseService().delete(id);
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
  void initState() {
  getTransaction();
  recentTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _proceedToNewTransaction(context),
        ),
      ],
    );

    final double height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.3,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
            SizedBox(
              height: height * 0.7,
              child: TransactionList(_userTransactions, _deleteTx, key: UniqueKey()),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          _proceedToNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
