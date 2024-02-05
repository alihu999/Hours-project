import 'package:hours/core/function/time_format.dart';
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

    await mydb!.execute(''' 
   CREATE TABLE "$tableName"(_id INTEGER PRIMARY KEY ,
   date TEXT,
   startAt TEXT,
   finishAt TEXT DEFAULT '00:00' ,
   breakSat TEXT DEFAULT '00:00',
   breakFat TEXT DEFAULT '00:00',
   breakH TEXT DEFAULT '00:00',
   workH TEXT DEFAULT '00:00',
   upload INTEGER DEFAULT 0
  )
    ''');
  }

  dropTable(String tableName) async {
    Database? mydb = await db;

    mydb!.execute("DROP TABLE $tableName");
  }

  insertData(String tableName) async {
    Database? mydb = await db;
    DateTime startAt = DateTime.now();
    await mydb!.rawInsert('''
   INSERT INTO $tableName(date,startAt) VALUES(
   "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day}",
   "${timeFormat(startAt.hour, startAt.minute)}")
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

  Future<int> numberRows(String tableName) async {
    Database? mydb = await db;

    var number = await mydb!.rawQuery("SELECT COUNT (*) FROM $tableName");
    return int.parse("${number[0]["COUNT (*)"]}");
  }

  Future<String> queryTime(String tableName, String timeName, int id) async {
    Database? mydb = await db;
    List<Map> respons = await mydb!.rawQuery("""
SELECT $timeName FROM $tableName WHERE _id=$id
""");
    return respons[0][timeName];
  }

  Future<Map> queryRow(String tableName, int id) async {
    Database? mydb = await db;
    List<Map> respons =
        await mydb!.rawQuery("""SELECT * FROM $tableName WHERE _id=$id""");
    return respons[0];
  }

  Future deleteRow(String tableName, int id) async {
    Database? mydb = await db;
    int respons =
        await mydb!.rawDelete(""" DELETE FROM $tableName WHERE _id=$id """);
    return respons;
  }

  Future deleteMultiRow(String tableName, int firstId, int lastId) async {
    Database? mydb = await db;
    int respons = await mydb!.rawDelete(
        """ DELETE FROM $tableName WHERE _id BETWEEN $firstId AND $lastId """);
    return respons;
  }
}
