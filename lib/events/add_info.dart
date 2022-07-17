// ignore_for_file: non_constant_identifier_names

import 'package:mute_help/model/info.dart';
import 'package:mute_help/events/info_event.dart';
import 'package:mute_help/model/travel_info.dart';
class AddInfo extends InfoEvent{
  static late  Info newInfo;
  
  AddInfo(Info? info){
     newInfo =  info!;
   }

  
}
class AddtravelInfo extends InfoEvent{
  static late TravelInfo newtravelInfo;
  AddtravelInfo(TravelInfo? travelInfo){
     newtravelInfo =  travelInfo!;
   }
}