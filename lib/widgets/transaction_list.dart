import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha_book/db/database_service.dart';
import 'package:kharcha_book/widgets/tx%20card/tx_card.dart';
import '../models/kharcha.dart';

class TransactionList extends StatefulWidget {
  final List<KharchaTransaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<Key> _keys = [];
  @override
  void initState() {
    DatabaseService().readKharcha();
    super.initState();
    _keys = widget.transactions.map((tx) => ValueKey(tx.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? Center(
            child: Text(
              "there is no transaction",
              style: GoogleFonts.pacifico(
                fontSize: 40.0,
              ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) => TxCard(
              key: _keys[index],
              transaction: widget.transactions[index],
              deleteTx: widget.deleteTx,
            ),
            itemCount: widget.transactions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 7),
          );
  }
}
