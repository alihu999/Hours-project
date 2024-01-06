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
   CREATE TABLE "$tableName"(_id INTEGER PRIMARY KEY ,
   date TEXT,
   startAt TEXT,
   finishAt TEXT ,
   breakSat TEXT,
   breakFat TEXT,
   hours INTEGER
  )
    ''');
    } catch (e) {
      print("ERROR: $e");
    }
  }

  insertData(String tableName, String fieled, String data) async {
    Database? mydb = await db;
    await mydb!.rawInsert('''
   INSERT INTO $tableName($fieled,) VALUES($data)
''');
  }

  Future<List<Map>> queryData(String tableName) async {
    Database? mydb = await db;
    List<Map> respons = await mydb!.rawQuery('''
   SELECT * FROM $tableName 
''');
    return respons;
  }
}
