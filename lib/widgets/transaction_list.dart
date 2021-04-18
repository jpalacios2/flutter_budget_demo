import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './expense_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;

  TransactionList({this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: transactionList.isNotEmpty
          ? transactionList
              .map(
                (t) => ExpenseCard(
                  cardColor: Theme.of(context).primaryColor,
                  width: double.infinity,
                  transactionTitle: t.transactionName,
                  transactionCost: t.transactionAmount,
                  transactionDate: t.transactionDate,
                ),
              )
              .toList()
          : Column(
              children: [Text('Nothing to see...')],
            ),
    );
  }
}
