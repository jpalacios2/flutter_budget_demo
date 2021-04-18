import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';
import 'package:get_utils/get_utils.dart';

class Chart extends StatelessWidget {
  List<Transaction> weeklyList;

  Chart({this.weeklyList});

  List<Map<String, Object>> get groupedTransactionValues {
    if (weeklyList.isNotEmpty) {
      return List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));

        //un-initialized variables should be set with data-type
        double dailyTotalSum = 0.0;

        for (int i = weeklyList.length - 1; i >= 0; i--) {
          if (weeklyList[i].transactionDate.month == weekDay.month &&
              weeklyList[i].transactionDate.day == weekDay.day &&
              weeklyList[i].transactionDate.year == weekDay.year) {
            dailyTotalSum += weeklyList[i].transactionAmount;
          }
        }

        return {
          'date': DateFormat.Md().format(weekDay),
          'day': DateFormat.E().format(weekDay),
          'amount': dailyTotalSum
        };
      });
    }

    return [];
  }

  double get totalSpending {
    double totalToReturn = 0.0;

    if (weeklyList.length > 0) {
      for (var i = 0; i < weeklyList.length; i++) {
        totalToReturn += weeklyList[i].transactionAmount;
      }
    }

    return totalToReturn;

/*
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
*/
  }

// ignore: todo
//TODO - Return 1 percent if percentage is lower than 1 percent
  double barTotalPercentage(e) {
    if (totalSpending > 0.0) {
      var percentage = ((e['amount'] as double) / totalSpending);

      if (percentage > 0.0 && percentage < 0.01) {
        //return 1 percent

        return .01;
      } else if (percentage > .9) {
        return .99;
      } else {
        return percentage.toPrecision(2);
      }
    }
    return 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
          children: groupedTransactionValues.reversed.map((e) {
        return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              dailySpendAmt: e['amount'],
              dayLabel: e['day'],
              totalPercentage: barTotalPercentage(e),
              dateLabel: e['date'],
            ));
      }).toList()),
    );
  }
}
