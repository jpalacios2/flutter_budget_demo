import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
//import './expense_item.dart';//Replaced with built in widget list_tile
import './new_expense.dart';
import './chart.dart';
import './transaction_collection.dart';
import 'package:flutter/cupertino.dart';

class HomeScaffold extends StatefulWidget {
  final List<Transaction> transactionList;
  final Function expenseUpdateHandler;
  final Function removeTransactinHandler;

  HomeScaffold(
      {this.transactionList,
      this.expenseUpdateHandler,
      this.removeTransactinHandler});

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (builderCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewExpense(expenseUpdateHandler: expenseUpdateHandler)
              //const Text('Hello')
              );
        });
  }

  List<Transaction> get _recentTransactions {
    //return [];

    if (transactionList.length > 0) {
      return transactionList.where((element) {
        return element.transactionDate
            .isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();
    } else {
      return [];
    }
  }

  bool _toogleChart = false;

  @override
  _HomeScaffold createState() => _HomeScaffold();
}

class _HomeScaffold extends State<HomeScaffold> {
  // String titleInput;
  // String amountInput;

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    final isLandscape = mediaQ.orientation.index == 1;
    final cupertinoAppBar = CupertinoNavigationBar(
      leading: const Text('Cupertino'),
      middle: const Text('Mid'),
      trailing: Row(
        children: [const Text('data')],
      ),
    );
    final appBar = AppBar(
        title: const Text('Expenses'),
        toolbarHeight: mediaQ.size.height * .06,
        //backgroundColor: Colors.green,
        actions: isLandscape
            ? []
            : [
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      widget.startAddNewTransaction(context);
                    })
              ]);
    final txCollection = Container(
      height: (mediaQ.size.height -
              appBar.preferredSize.height -
              mediaQ.padding.top) *
          .85,
      child: TransactionCollection(
        removeTransactinHandler: widget.removeTransactinHandler,
        transactionList: widget.transactionList,
      ),
    );
    final nothingToSee = LayoutBuilder(builder: (context, contraints) {
      return Column(
        children: [
          Column(
            children: [
              const Text('Nothing to see...'),
              SizedBox(
                height: contraints.maxHeight * .1,
              ),
              Container(
                height: contraints.maxHeight * .8,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          )
        ],
      );
    });
    final pageBody = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isLandscape
                ? Row(
                    children: [
                      Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      CupertinoSwitch(
                          trackColor: Theme.of(context).accentColor,
                          activeColor: Theme.of(context).primaryColor,
                          value: widget._toogleChart,
                          onChanged: (val) {
                            if (widget.transactionList.isNotEmpty) {
                              setState(() {
                                widget._toogleChart = val;
                              });
                            }
                          })
                      /*Switch.adaptive(
                              value: widget._toogleChart,
                              onChanged: (val) {
                                if (widget.transactionList.isNotEmpty) {
                                  setState(() {
                                    widget._toogleChart = val;
                                  });
                                }
                              },
                            )*/
                    ],
                  )
                : SizedBox()
          ],
        ),
        if (!isLandscape)
          Container(
            height: (mediaQ.size.height -
                    appBar.preferredSize.height -
                    mediaQ.padding.top) *
                .3,
            child: Chart(
              weeklyList: widget.transactionList,
            ),
          ),
        if (!isLandscape)
          Container(
            //margin: const EdgeInsets.all(25),CALCULATE OVERALL SIZE BEFORE APPLYING MARGINS (MediaQ - whatever * deisired percentage)
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: widget.transactionList.isNotEmpty
                        ? Colors.blueGrey
                        : null,
                  ),
                  height: (mediaQ.size.height -
                          appBar.preferredSize.height -
                          mediaQ.padding.top) *
                      .58, //multiply by percentage to determine what percentage is taken

                  child: widget.transactionList.isNotEmpty
                      ? txCollection
                      : Container(
                          height: (mediaQ.size.height -
                                  appBar.preferredSize.height) *
                              .02,
                          child: nothingToSee,
                        ),
                ),
              ],
            ),
          ),
        if (isLandscape && widget._toogleChart)
          Container(
            height: (mediaQ.size.height -
                    appBar.preferredSize.height -
                    mediaQ.padding.top) *
                .7,
            child: Chart(
              weeklyList: widget.transactionList,
            ),
          ),
        if (isLandscape && !widget._toogleChart) txCollection,
        if (isLandscape && widget._recentTransactions.isEmpty)
          const Text('Nothing to see...')
      ],
    );

/**
 * Main return
*/
    return /*Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: cupertinoAppBar,
          )
        : */
        Scaffold(
      //bottomNavigationBar: const Text('NAV'),
      appBar: appBar,
      body: SafeArea(
        child: Container(
          color: Colors.grey[50],
          child: pageBody,
        ),
      ),

      floatingActionButton: !isLandscape
          ? Container(
              height: (mediaQ.size.height -
                      appBar.preferredSize.height -
                      mediaQ.padding.top) *
                  .1,
              width: mediaQ.size.width,
              child: TextButton(
                  onPressed: () {
                    widget.startAddNewTransaction(context);
                  },
                  child: const Text('Add'),
                  style: ButtonStyle(
                      alignment: Alignment.bottomCenter,
                      shape: MaterialStateProperty.all(
                          ContinuousRectangleBorder()),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black))))
          : FloatingActionButton(
              child: const Icon(Icons.add),
              foregroundColor: Colors.green,
              //backgroundColor: Colors.yellow,
              onPressed: () {
                widget.startAddNewTransaction(context);
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
