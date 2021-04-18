import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String transactionName;
  final DateTime transactionDate;
  final double transactionAmount;

  Transaction(
      {@required this.id,
      @required this.transactionName,
      @required this.transactionDate,
      @required this.transactionAmount});
}
