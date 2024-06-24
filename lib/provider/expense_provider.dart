import 'package:expense_tracker/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/class/expense_class.dart';

import '../constants/tittle_enum.dart';



class ExpenseProvider extends ChangeNotifier {

  List<ExpenseData> listOfCard = [];

  double finalAmountGeneral = 0.0;
  double finalAmountFoods = 0.0;
  double finalAmountFuels = 0.0;
  double finalAmountMisc = 0.0;

  double threshold = 0;

  Future<void> getData() async {
    final variable  = await DatabaseHelper().getQuery();
    listOfCard= variable;
    finalAmountGeneral = 0.0;
    finalAmountFoods = 0.0;
    finalAmountFuels = 0.0;
    finalAmountMisc = 0.0;

    threshold = 0;
    for (var x in listOfCard){
      switch (x.whichTitle!) {
        case tittle.General:
          finalAmountGeneral += int.parse(x.amount);
          break;
        case tittle.Fuels:
          finalAmountFuels += int.parse(x.amount);
          break;
        case tittle.Foods:
          finalAmountFoods += int.parse(x.amount);
          break;
        case tittle.Misc:
          finalAmountMisc += int.parse(x.amount);
          break;
        default:
          threshold += 0;
          break;
      }
    }
    threshold = finalAmountMisc+finalAmountFoods+finalAmountFuels+finalAmountGeneral;
  }

  void addToList(ExpenseData expense) async {

    await DatabaseHelper().insertExpense(expense);
    listOfCard.add(expense);
    threshold += int.parse(expense.amount);
    switch (expense.whichTitle!) {
      case tittle.General:
        finalAmountGeneral += int.parse(expense.amount);
        break;
      case tittle.Fuels:
        finalAmountFuels += int.parse(expense.amount);
        break;
      case tittle.Foods:
        finalAmountFoods += int.parse(expense.amount);
        break;
      case tittle.Misc:
        finalAmountMisc += int.parse(expense.amount);
        break;
      default:
        threshold += 0;
        break;
    }
    notifyListeners();
  }

  double getSum(tittle tx) {
    switch (tx) {
      case tittle.General:
        {
          return finalAmountGeneral;
        }
      case tittle.Fuels:
        {
          return finalAmountFuels;
        }
      case tittle.Foods:
        {
          return finalAmountFoods;
        }
      case tittle.Misc:
        {
          return finalAmountMisc;
        }
      default:
        return 1;
    }
  }

  void deleteItem(DateTime id) async {
    await DatabaseHelper().deleteExpense(id);

    final ExpenseData expenseData =
        listOfCard.where((element) => element.uniqueKey == id).first;
    listOfCard.remove(expenseData);
    threshold -= int.parse(expenseData.amount);
    switch (expenseData.whichTitle!) {
      case tittle.General:
        finalAmountGeneral -= int.parse(expenseData.amount);
        break;
      case tittle.Fuels:
       finalAmountFuels -= int.parse(expenseData.amount);
       break;
      case tittle.Foods:
        finalAmountFoods -= int.parse(expenseData.amount);
        break;
      case tittle.Misc:
        finalAmountMisc -= int.parse(expenseData.amount);
        break;
    }
    notifyListeners();
  }

  void undoDelete(ExpenseData expenseData) async {
    await DatabaseHelper().insertExpense(expenseData);
    listOfCard.add(expenseData);
    threshold += int.parse(expenseData.amount);
    switch (expenseData.whichTitle!) {
      case tittle.General:
        finalAmountGeneral += int.parse(expenseData.amount);
        break;
      case tittle.Fuels:
        finalAmountFuels += int.parse(expenseData.amount);
        break;
      case tittle.Foods:
        finalAmountFoods += int.parse(expenseData.amount);
        break;
      case tittle.Misc:
        finalAmountMisc += int.parse(expenseData.amount);
        break;
    }
    notifyListeners();

  }

  IconData getIcon(tittle tx){
    switch (tx) {
      case tittle.General:
       return Icons.work;
      case tittle.Fuels:
       return Icons.pedal_bike;
      case tittle.Foods:
        return Icons.emoji_food_beverage;
      case tittle.Misc:
        return Icons.add;
      default:
        return Icons.add;
    }
  }
}
