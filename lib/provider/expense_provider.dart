import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/class/class.dart';


enum tittle {
  General,
  Foods,
  Fuels,
  Misc
}

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseData> listOfCard = [];

  double finalAmountGeneral = 0.0;
  double finalAmountFoods = 0.0;
  double finalAmountFuels = 0.0;
  double finalAmountMisc = 0.0;

  double threshold = 0;

  void addToList(ExpenseData expense) {
    listOfCard.add(expense);
    threshold += int.parse(expense.amount);
    print('Threshold is $threshold');
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
        return 10.0;
    }
  }

  void deleteItem(DateTime id) {
    final ExpenseData expenseData =
        listOfCard.where((element) => element.uniqueKey == id).first;
    listOfCard.remove(expenseData);
    threshold -= int.parse(expenseData.amount);
    switch (expenseData.whichTitle!) {
      case tittle.General:
        finalAmountGeneral -= int.parse(expenseData.amount);
      case tittle.Fuels:
       finalAmountFuels -= int.parse(expenseData.amount);
      case tittle.Foods:
        finalAmountFoods -= int.parse(expenseData.amount);
      case tittle.Misc:
        finalAmountMisc -= int.parse(expenseData.amount);
    }
    notifyListeners();
  }

  void undoDelete(ExpenseData expenseData) {
    listOfCard.add(expenseData);
    threshold += int.parse(expenseData.amount);
    switch (expenseData.whichTitle!) {
      case tittle.General:
        finalAmountGeneral += int.parse(expenseData.amount);
      case tittle.Fuels:
        finalAmountFuels += int.parse(expenseData.amount);
      case tittle.Foods:
        finalAmountFoods += int.parse(expenseData.amount);
      case tittle.Misc:
        finalAmountMisc += int.parse(expenseData.amount);
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
