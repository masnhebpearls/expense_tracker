import 'package:expense_tracker/class/expense_class.dart';
import 'package:expense_tracker/constants/constant_helper.dart';
import 'package:expense_tracker/constants/tittle_enum.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, '${ConstantHelper.databaseName}.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE ${ConstantHelper.databaseName}('
              '${ConstantHelper.idColumn} TEXT PRIMARY KEY, '
              '${ConstantHelper.tittleColumn} TEXT, '
              '${ConstantHelper.amountColumn} TEXT, '
              '${ConstantHelper.dateColumn} TEXT, '
              '${ConstantHelper.categoryColumn} TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertExpense(ExpenseData data) async {
    final db = await database();
    Map<String, dynamic> row = {
      ConstantHelper.idColumn: data.uniqueKey.toString(),
      ConstantHelper.tittleColumn: data.title,
      ConstantHelper.amountColumn: data.amount,
      ConstantHelper.dateColumn: data.date,
      ConstantHelper.categoryColumn: data.whichTitle!.name,
    };
    await db.insert(
      ConstantHelper.databaseName,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ExpenseData>> getQuery() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(ConstantHelper.databaseName);
    print('on database');
    print("length is ${maps.length}");
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(
      maps.length,
          (index) => ExpenseData(
        title: maps[index][ConstantHelper.tittleColumn],
        amount: maps[index][ConstantHelper.amountColumn],
        date: maps[index][ConstantHelper.dateColumn],
        whichTitle: getTittle(maps[index][ConstantHelper.categoryColumn]),
        uniqueKey: DateTime.tryParse(maps[index][ConstantHelper.idColumn]) ?? DateTime.now(),
      ),
    );
  }

  Future<void> deleteExpense(DateTime key) async {
    final db = await database();
    await db.delete(
      ConstantHelper.databaseName,
      where: "${ConstantHelper.idColumn} = ?",
      whereArgs: [key.toString()],
    );
  }

  tittle getTittle(String val) {
    final switchVal = val.toLowerCase();
    switch (switchVal) {
      case "general":
        return tittle.General;
      case "foods":
        return tittle.Foods;
      case "fuels":
        return tittle.Fuels;
      case "misc":
        return tittle.Misc;
      default:
        return tittle.General;
    }
  }
}
