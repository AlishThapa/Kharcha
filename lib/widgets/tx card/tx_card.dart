import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kharcha_book/db/database_service.dart';
import 'package:kharcha_book/screens/homepage/home_page.dart';
import '../../models/kharcha.dart';

class TxCard extends StatelessWidget {
  const TxCard({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final KharchaTransaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.78,
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.greenAccent.withOpacity(0.65),
            ),
            child: Row(
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey.shade800,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat.yMMMd().format(transaction.date ?? DateTime.now()),
                  style: GoogleFonts.chivo(
                    color: Colors.deepPurple,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Rs ${transaction.amount.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey.shade800,
                  ),
                )
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.blueGrey,
            onPressed: () {
            DatabaseService().delete(transaction.id!);
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyHomePage(),));
            }
          ),
        ],
      ),
    );
  }
}
