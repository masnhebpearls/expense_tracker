import 'package:expense_tracker/provider/expense_provider.dart';

import '../constants/tittle_enum.dart';

class ExpenseData {
  final String title;
  final String amount;
  final String date;
  final tittle? whichTitle;
  final DateTime uniqueKey;

  ExpenseData(
      {required this.title,
      required this.amount,
      required this.date,
      required this.whichTitle,
      required this.uniqueKey});
}
