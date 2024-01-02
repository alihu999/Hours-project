import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    //create path for database
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'EmployeesRecords.db');
    //open database
    Database myDB = await openDatabase(path);
    return myDB;
  }

  createTable(String tableName) async {
    Database? mydb = await db;
    try {
      await mydb!.execute(''' 
    CREATE TABLE "$tableName" (id INTEGER  NOT NULL ,day TEXT NOT NULL)
    ''');
    } catch (e) {
      //print("eroooor: $e");
    }
  }
}
