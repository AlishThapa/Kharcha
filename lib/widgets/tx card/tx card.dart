import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../kharcha.dart';
import 'amount.dart';

class TxCard extends StatelessWidget {
  const TxCard({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  });

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: Amount(amount: transaction.amount),
        title: Text(
          transaction.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey.shade800,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: GoogleFonts.chivo(
            color: Colors.deepPurple,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Colors.blueGrey,
          onPressed: () => deleteTx(transaction.id),
        ),
      ),
    );
  }
}
