import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final Function expenseUpdateHandler;
  NewExpense({this.expenseUpdateHandler}) {}

  //final TextEditingController _titleInputController = TextEditingController();
  //final TextEditingController _amountInputController = TextEditingController();
  final FocusNode _titleInputNode = FocusNode();
  final FocusNode _amountInputNode = FocusNode();

  void addToExpenses(_titleInput, _amountInput, _date) {
    print('Adding ${_titleInput} from widget');
    var didAccept = expenseUpdateHandler(
        title: _titleInput, value: _amountInput, date: _date);

    if (!didAccept) return;

    _titleInput = '';
    _amountInput = '';

    print('new ${_titleInput}... from widget');
  }

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  String _titleInput;
  String _amountInput;
  TextEditingController _titleInputController = TextEditingController();
  TextEditingController _amountInputController = TextEditingController();
  DateTime _selectedDate = null;

  void _submitHandler() {
    widget.addToExpenses(_titleInput, _amountInput, _selectedDate);
    _titleInputController.clear();
    _amountInputController.clear();
    Navigator.of(context).pop();
  }

/*Can also use a Promise like syntax instead of async await
  Future<void> _datePickerModal(context) async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now()) as DateTime;

    if (pickedDate != null) {
      print('Date picked ${pickedDate}');
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
*/
  void _datePickerModal(context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      print('Date picked ${pickedDate}');
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      color: Colors.pink[100],
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 0, //MediaQuery.of(context).viewInsets.top,
        bottom: 0,
      ), //MediaQuery.of(context).viewInsets.bottom),
      child: Column(children: [
        TextField(
          //focusNode: widget._titleInputNode,
          decoration: InputDecoration(labelText: 'Expense Name'),
          controller: _titleInputController,
          onChanged: (val) {
            _titleInput = val;
          },
          onSubmitted: (_) => _submitHandler(),
        ),
        TextField(
          //focusNode: widget._amountInputNode,
          decoration: InputDecoration(labelText: 'Cost'),
          controller: _amountInputController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => _submitHandler(),
          onChanged: (val) {
            _amountInput = val;
          },
        ),
        Row(
          children: [
            Text(_selectedDate == null
                ? 'No Date Selected'
                : 'Slected Date ${DateFormat('MMMM d, y').format(_selectedDate).toString()}'),
            Expanded(
                child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: TextButton(
                        onPressed: () {
                          _datePickerModal(context);
                        },
                        child: Text(
                          'Select Date',
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            elevation: 5,
                            backgroundColor: Theme.of(context).accentColor,
                            alignment: Alignment.topRight))))
          ],
        ),
        Container(
            alignment: Alignment.bottomCenter,
            //margin: EdgeInsets.symmetric(vertical: 25),
            child: TextButton(
                onPressed: () => _submitHandler(),
                child: Text(
                  'Add Expense',
                ),
                style: TextButton.styleFrom(
                    primary: Colors.yellow,
                    elevation: 5,
                    backgroundColor: Colors.green[500],
                    alignment: Alignment.topRight)))
      ]),
    ));
  }
}
