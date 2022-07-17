// ignore_for_file: constant_identifier_names

import 'package:mute_help/model/info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_INFO = "info";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_DOB = "dob";
  static const String COLUMN_PHONENO = "phoneNo";
  static const String COLUMN_ADDRESS = "address";
  static const String COLUMN_QUALIFICATION = "qualification";


DatabaseProvider._();
static final DatabaseProvider db = DatabaseProvider._();
Database? _database;

Future<Database> get database async {
  // print("database getter called");

  if (_database != null) {
    return _database!;
  }

  _database = await createDatabase();

  return _database!;
}

Future<Database> createDatabase() async {
  String dbPath = await getDatabasesPath();

  return await openDatabase(
    join(dbPath, 'topDB.db'),
    version: 1,
    onCreate: (Database database, int version) async {
      // print("Creating info table");

      await database.execute(
        "CREATE TABLE $TABLE_INFO("
        "$COLUMN_ID  INTEGER PRIMARY KEY,"
        "$COLUMN_NAME TEXT,"
        "$COLUMN_EMAIL TEXT,"
        "$COLUMN_DOB TEXT,"
        "$COLUMN_PHONENO TEXT,"
        "$COLUMN_ADDRESS TEXT,"
        "$COLUMN_QUALIFICATION TEXT"
        ")",
      );
    },
  );
}


Future<List<Info>> getInfo() async{
  final db = await database;
  var infos =await db.query(TABLE_INFO,columns:[COLUMN_ID,COLUMN_NAME,COLUMN_EMAIL,COLUMN_DOB,COLUMN_PHONENO,COLUMN_ADDRESS,COLUMN_QUALIFICATION]);

  List<Info> infoList = [];
  
  // ignore: avoid_function_literals_in_foreach_calls
  infos.forEach((currentInfo) { 
    Info info = Info.fromMap(currentInfo);
    infoList.add(info);
   // print("info in ${infoList[0]}");
   });
   return infoList;
}

Future<Info> insert(Info info) async{
  final db =  await database;
  info.id= await db.insert(TABLE_INFO, info.toMap());
  return info;
}
Future<int> delete(int? id) async {
    final db = await database;

    return await db.delete(
      TABLE_INFO,
      where: "id = ?",
      whereArgs: [id],
    );
  }
Future<int> update(Info? info) async{
  final db = await database;
  return await db.update(TABLE_INFO,info!.toMap(),where: "id=?",whereArgs: [info.id]);
}
}