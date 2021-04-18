import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChartBar extends StatelessWidget {
  final String dayLabel;
  final String dateLabel;
  final double dailySpendAmt;
  final double totalPercentage;

  ChartBar(
      {this.dayLabel,
      this.dailySpendAmt,
      this.totalPercentage,
      this.dateLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: LayoutBuilder(builder: (cxt, contraints) {
          return Column(
            children: [
              Container(
                  height: contraints.maxHeight *
                      .1, //text will always have a height of 20, text will always be aligned no matter if resized
                  child: FittedBox(
                      child: Text('\$${dailySpendAmt.toStringAsFixed(0)}'))),
              Container(
                height: contraints.maxHeight * .08,
              ),
              Container(
                height: contraints.maxHeight * .5,
                width: 20,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1),
                          borderRadius: BorderRadius.circular(1)),
                    ),
                    FractionallySizedBox(
                      heightFactor: (1 -
                          totalPercentage), //deduct 1 by percentage to get correct graph position
                      alignment: Alignment.topCenter,
                      child: Container(
                        //alignment: Alignment.topCenter,
                        //transformAlignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(1)),
                        //color: Color.fromRGBO(100, 200, 300, 1)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: contraints.maxHeight * .08,
              ),
              Container(
                  height: contraints.maxHeight *
                      .1, //text will always have a height of 20, text will always be aligned no matter if resized
                  child: FittedBox(
                    child: Text('${dayLabel}'),
                  )),
              Container(
                  height: contraints.maxHeight *
                      .1, //text will always have a height of 20, text will always be aligned no matter if resized
                  child: FittedBox(
                    child: Text('${dateLabel}'),
                  ))
            ],
          );
        }));
  }
}
