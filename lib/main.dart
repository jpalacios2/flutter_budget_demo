//import 'dart:io';
import 'package:flutter/material.dart';
import 'widgets/home.dart';
import 'models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  /*
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  */
  runApp(CashMonitorApp());
}

class CashMonitorApp extends StatefulWidget {
  @override
  _CashMonitorAppState createState() => _CashMonitorAppState();
}

class _CashMonitorAppState extends State<CashMonitorApp> {
  //final List<Transaction> transactions1 = new List();
  final List<Transaction> transactions = [
    Transaction(
        id: 't1',
        transactionName: 'Pizza',
        transactionDate: DateTime.now().subtract(Duration(days: 1)),
        transactionAmount: 150.00),
    Transaction(
        id: 't4',
        transactionName: 'Mac',
        transactionDate: DateTime.now().subtract(Duration(days: 2)),
        transactionAmount: 350.00),
    Transaction(
        id: 't2',
        transactionName: 'Electric bill',
        transactionDate: DateTime.now().subtract(Duration(days: 3)),
        transactionAmount: 45.00),
    Transaction(
        id: 't3',
        transactionName: 'Pizza',
        transactionDate: DateTime.now().subtract(Duration(days: 4)),
        transactionAmount: 15.00),
  ];

  bool addTransactionHandler({String value, String title, DateTime date}) {
    if (double.parse(value) <= 0 || title.isEmpty || date == null) {
      return false;
    }

    print('made it home');

    setState(() {
      transactions.add(new Transaction(
          id: 'id_' + date.toIso8601String(),
          transactionName: title,
          transactionDate: date,
          transactionAmount: double.parse(value)));
    });
    return true;
  }

  void removeTransactinHandler({index: int, id: String}) {
    setState(() {
      //transactions.removeAt(index);

      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    return MaterialApp(
      home: //SingleChildScrollView(child:
          HomeScaffold(
        transactionList: transactions,
        expenseUpdateHandler: addTransactionHandler,
        removeTransactinHandler: removeTransactinHandler,
      ),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme:
              AppBarTheme(elevation: 10, backgroundColor: Colors.red[600]),
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
    );
  }
}
