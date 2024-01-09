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

  insertData(String tableName) async {
    Database? mydb = await db;
    await mydb!.rawInsert('''
   INSERT INTO $tableName(date,startAt) VALUES(
   "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
   "${DateTime.now().hour.toString().padLeft(2, "0")}:${DateTime.now().minute.toString().padLeft(2, "0")}")
''');
  }

  updateData(String tableName, String filed, String data, int id) async {
    Database? mydb = await db;
    await mydb!.rawUpdate('''
   UPDATE $tableName SET $filed="$data" WHERE _id=$id
''');
  }

  Future<List<Map>> queryData(String tableName) async {
    Database? mydb = await db;
    List<Map> respons = await mydb!.query(tableName);
    return respons;
  }
}
