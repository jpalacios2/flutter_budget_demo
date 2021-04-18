import 'package:flutter/material.dart';
import 'transaction_item.dart';

class TransactionCollection extends StatelessWidget {
  final transactionList;
  final Function removeTransactinHandler;

  TransactionCollection(
      {@required this.transactionList, @required this.removeTransactinHandler});
  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    return ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (context, i) {
        return TransactionItem(
            //List Views with STATEFUL Widgets (Widgets that manage their own data)
            //Use a value key like so, DO NOT USE regenerated unique keys!!!
            key: Key(transactionList[i].id),
            transactionList: transactionList,
            removeTransactinHandler: removeTransactinHandler,
            mediaQ: mediaQ,
            i: i);
      },
    );
  }
}
