import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../repository/model/expensemodel.dart';

class AddDetailController extends ChangeNotifier {
  List<ExpenseModel> expenses = [];
  List<ExpenseModel> income = [];
  List<ExpenseModel> expenselist = [];

  int totalinc = 0 ;
  var totalexp = 0;


  List<ExpenseModel> rev = [];
  List<ExpenseModel> revincome = [];
  List<ExpenseModel> revexpense = [];


  var box = Hive.box('mybox');
  var inc = Hive.box('income');
  var exp = Hive.box('expense');
  var bal = Hive.box('balance');

  var totalincome = Hive.box('totalincom');
  var totalexpense = Hive.box('totalexpenss');



  void expenseList(ExpenseModel value) {
    var data = value;
    box.add(data);
    expenses.addAll(box.values.map((dynamic value) => value));
    rev = expenses.reversed.toList();
    if (value.transactiontype == "Income") {
     var  totalinc1 = totalinc +  int.parse(value.amount ?? "0");
      totalincome.put('incomes', totalinc1);

      inc.add(data);
      income.addAll(inc.values.map((dynamic value) => value));
      revincome = income.reversed.toList();
      notifyListeners();
    } else {
     var  totalexp1 = totalexp + int.parse(value.amount ?? "0");
      totalexpense.put('expenss', totalexp1);

      exp.add(data);
      expenselist.addAll(exp.values.map((dynamic value) => value));
      revexpense = expenselist.reversed.toList();
      notifyListeners();
    }

    getalldetails();
    notifyListeners();
  }

   getalldetails() {
    expenses.clear();
    income.clear();
    expenselist.clear();

    totalinc = totalincome.get('incomes',defaultValue: 0);
    totalexp = totalexpense.get('expenss',defaultValue: 0);




    expenses.addAll(box.values.map((dynamic value) => value));
    rev = expenses.reversed.toList();
    income.addAll(inc.values.map((dynamic value) => value));
    revincome = income.reversed.toList();
    expenselist.addAll(exp.values.map((dynamic value) => value));
    revexpense = expenselist.reversed.toList();

    notifyListeners();
  }

  void Addbalance({required String value}) {
    var t = int.parse(value);
    bal.put('baln', t);

    notifyListeners();
  }

  totalbalance({required ExpenseModel value}) {
    var tot = bal.get('baln', defaultValue: 0);
    var number = int.parse(value.amount!);
    var i = totalincome.get('incomes', defaultValue: 0);
    var j = totalexpense.get('expenss', defaultValue: 0);
    if (value.transactiontype == "Income") {
      num tot1 = tot + number;
      bal.put('baln', tot1);
      notifyListeners();
    } else {
      num tot1 = tot - number;
      bal.put('baln', tot1);
      notifyListeners();
    }
    notifyListeners();
  }
}
