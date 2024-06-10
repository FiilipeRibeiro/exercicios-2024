import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../data/db.dart';
import '../model/chuva_model.dart';

class SaveController extends ChangeNotifier {
  static const String tablename = 'chuvaTable';
  static const String title = 'title';
  static const String isSaved = 'isSaved';

  static const String tableSql = 'CREATE TABLE $tablename('
      '$title TEXT, '
      '$isSaved INTEGER)';

  List<String> savedActivities = [];

  Future<void> save(ChuvaModel chuva) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> existingItem = await db.query(
      tablename,
      where: '$title = ?',
      whereArgs: [chuva.title],
    );

    if (existingItem.isEmpty) {
      Map<String, dynamic> chuvaMap = chuva.toMap();
      await db.insert(SaveController.tablename, chuvaMap);
      chuva.isSaved = true;

      savedActivities.add(chuva.title);
      print(savedActivities);
      notifyListeners();
    } else {
      print('Item já existe no banco de dados.');
    }
  }

  Future<void> deleteOne(ChuvaModel chuva) async {
    final Database db = await getDatabase();
    await db.delete(
      SaveController.tablename,
      where: '$title = ?',
      whereArgs: [chuva.title],
    );
    chuva.isSaved = false;

    savedActivities.remove(chuva.title);
    notifyListeners();
  }

  // Future<void> deleteAll() async {
  //   final Database db = await getDatabase();
  //   await db.delete(SaveController.tablename);

  //   savedActivities.clear();
  //   notifyListeners();
  // }

  Future<void> printAllData() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> results =
        await db.query(SaveController.tablename);

    print(results);
  }

  bool isActivitySaved(String title) {
    return savedActivities.contains(title);
  }
}
