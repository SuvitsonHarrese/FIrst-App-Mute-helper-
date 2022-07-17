// ignore_for_file: non_constant_identifier_names

import 'package:mute_help/db/travel_db_provider.dart';
class TravelInfo{
  int ? id;
  String ? BusArrival;
  String? BusDepart;
  String? TrainArrival;
  String? TrainDepart;
  String? TripType;
  TravelInfo({this.id,this.BusArrival,this.BusDepart,this.TrainArrival,this.TrainDepart,this.TripType});
  Map<String, dynamic> toMap(){
    var map = <String,dynamic >{
      TravelDB.COLUMN_BusArrival:BusArrival,
      TravelDB.COLUMN_BusDepart: BusDepart,
      TravelDB.COLUMN_TrainArrival: TrainArrival,
      TravelDB.COLUMN_TrainDepart : TrainDepart,
      TravelDB.COLUMN_TripType :TripType,
    };
    if(id!=null){
      map[TravelDB.COLUMN_ID] = id;
    }
    // print("ID value $id");
    return map;
  }

  TravelInfo.fromMap(Map<String,dynamic> map){
    id = map[TravelDB.COLUMN_ID];
    BusArrival = map[TravelDB.COLUMN_BusArrival];
    BusDepart = map[TravelDB.COLUMN_BusDepart];
    TrainArrival = map[TravelDB.COLUMN_TrainArrival];
    TrainDepart = map[TravelDB.COLUMN_TrainDepart];
   TripType = map[TravelDB.COLUMN_TripType];
  }
}