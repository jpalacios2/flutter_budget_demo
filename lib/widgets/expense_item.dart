import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final double width;
  final String transactionTitle;
  final double transactionCost;
  final Color cardColor;
  final DateTime transactionDate;

  ExpenseCard(
      {this.width,
      @required this.transactionTitle,
      this.cardColor,
      this.transactionCost,
      this.transactionDate});

  @override
  Widget build(BuildContext context) {
    //String formattedDate = DateFormat('MM-dd-yyyy').format(transactionDate);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        width: double.infinity,
        alignment: Alignment.topRight,
        //color: Colors.red,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0, style: BorderStyle.solid)),
        child: Card(
          color: cardColor != null ? cardColor : Colors.orange,
          child: Row(
            children: [
              Container(
                child: Text(
                  '\$ ${transactionCost.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                //alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid)),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          transactionTitle,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        //decoration: BoxDecoration(color: Colors.red),
                        color: Colors.white70,
                        alignment: Alignment.center,
                        //color: Colors.pink,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                      ),
                      Container(
                        child: Text(
                          //formattedDate.toString(),
                          DateFormat('MMMM d, y')
                              .format(transactionDate)
                              .toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        alignment: Alignment.center,
                        //color: Colors.purple,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                      )
                    ],
                  )),
            ],
          ),
          elevation: 10,
        ));
  }
}

/*
  @override
  Widget build(BuildContext context) {
    //String formattedDate = Date('MM-dd-yyyy').format(transactionDate);
    return ListBody(
      children: [
        Card(
          color: cardColor != null ? cardColor : Colors.orange,
          child: Container(
              alignment: Alignment.center,
              width: width != null ? width : 200,
              child: Text(
                transactionTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          elevation: 10,
        ),
        Card(
          color: cardColor != null ? Colors.green : Colors.green,
          child: Container(
              alignment: Alignment.center,
              width: width != null ? width : 200,
              child: Text(
                transactionCost.toString(),
                style: TextStyle(fontWeight: FontWeight.normal),
              )),
          elevation: 10,
        ),
        Card(
          color: cardColor != null ? Colors.green : Colors.green,
          child: Container(
              alignment: Alignment.center,
              width: width != null ? width : 200,
              child: Text(
                transactionDate.toString(),
                style: TextStyle(fontWeight: FontWeight.normal),
              )),
          elevation: 10,
        )
      ],
    );
  }
  */
