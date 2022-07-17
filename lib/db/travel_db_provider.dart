// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mute_help/model/travel_info.dart';

class TravelDB{
  static const String TABLE_TravelINFO = "travel_info";
  static const String COLUMN_ID = "id";
  static const String COLUMN_BusArrival = "BusArrival";
  static const String COLUMN_BusDepart = "BusDepart";
  static const String COLUMN_TrainArrival = "TrainArrival";
  static const String COLUMN_TrainDepart = "TrainDepart";
  static const String COLUMN_TripType = "TripType";

  
TravelDB._();
static final TravelDB db = TravelDB._();
Database? _database;

Future<Database> get database async {
  // print("database of travel getter called");

  if (_database != null) {
    return _database!;
  }

  _database = await createDatabase();

  return _database!;
}

Future<Database> createDatabase() async {
  String dbPath = await getDatabasesPath();

  return await openDatabase(
    join(dbPath, 'travel_infoDB.db'),
    version: 1,
    onCreate: (Database database, int version) async {
      // print("Creating travel info table");

      await database.execute(
        "CREATE TABLE $TABLE_TravelINFO("
        "$COLUMN_ID  INTEGER PRIMARY KEY,"
        "$COLUMN_BusArrival TEXT,"
        "$COLUMN_BusDepart TEXT,"
        "$COLUMN_TrainArrival TEXT,"
        "$COLUMN_TrainDepart TEXT,"
        "$COLUMN_TripType TEXT"
        ")",
      );
    },
  );
}
Future<List<TravelInfo>> getInfo() async{
  final db = await database;
  var travel_infos =await db.query(TABLE_TravelINFO,columns:[COLUMN_ID,COLUMN_BusArrival,COLUMN_BusDepart,COLUMN_TrainArrival,COLUMN_TrainDepart,COLUMN_TripType]);
  // print("I am in getInfo");
  List<TravelInfo> travelinfoList = [];
  
  // ignore: avoid_function_literals_in_foreach_calls
  travel_infos.forEach((currentTravelInfo) { 
    TravelInfo info = TravelInfo.fromMap(currentTravelInfo);
    travelinfoList.add(info);
   // print("info in ${travelinfoList[0]}");
   });
   return travelinfoList;
}

Future<TravelInfo> insert(TravelInfo travelinfo) async{
  final db =  await database;
  travelinfo.id= await db.insert(TABLE_TravelINFO, travelinfo.toMap());
  return travelinfo;
}
Future<int> delete(int? id) async {
    final db = await database;

    return await db.delete(
      TABLE_TravelINFO,
      where: "id = ?",
      whereArgs: [id],
    );
  }
Future<int> update(TravelInfo? travelinfo) async{
  final db = await database;
  return await db.update(TABLE_TravelINFO,travelinfo!.toMap(),where: "id=?",whereArgs: [travelinfo.id]);
}

  
}