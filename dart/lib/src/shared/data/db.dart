import 'package:chuva_dart/src/shared/controller/save_controller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  String path = join(await getDatabasesPath(), 'chuva.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(SaveController.tableSql);
    },
    version: 1,
  );
}
