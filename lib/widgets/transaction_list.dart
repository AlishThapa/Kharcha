import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha_book/widgets/tx%20card/tx%20card.dart';
import '../kharcha.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: Text(
              "there is no transaction",
              style: GoogleFonts.pacifico(
                fontSize: 40.0,
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) =>
            TxCard(transaction: transactions[index],deleteTx: deleteTx,),
            itemCount: transactions.length,

          );
  }
}
