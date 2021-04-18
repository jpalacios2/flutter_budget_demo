import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class TransactionItem extends StatelessWidget {
  final transactionList;
  final Function removeTransactinHandler;
  final mediaQ;
  final i;

  TransactionItem(
      {Key key,
      this.transactionList,
      this.removeTransactinHandler,
      this.mediaQ,
      this.i});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: ListTile(
          title: Text(
            transactionList[i].transactionName,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(DateFormat('MMMM d, y')
              .format(transactionList[i].transactionDate)
              .toString()),
          leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                        '\$${transactionList[i].transactionAmount}'.toString()),
                  ))),
          trailing: mediaQ.size.width > 400
              ? TextButton.icon(
                  onPressed: () {
                    removeTransactinHandler(id: transactionList[i].id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  label: Text(
                    'DELETE',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () {
                    removeTransactinHandler(id: transactionList[i].id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                ),
        ));
  }
}
