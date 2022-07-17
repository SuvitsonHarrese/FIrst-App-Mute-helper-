// ignore_for_file: non_constant_identifier_names

import 'package:mute_help/model/info.dart';
import 'package:mute_help/events/info_event.dart';
import 'package:mute_help/model/travel_info.dart';
class SetInfos extends InfoEvent{
  static late List<Info> infoList;
  
  SetInfos(List<Info>? infos){
    infoList = infos!;
  }
 
}
class SettravelInfos extends InfoEvent{
  static late List<TravelInfo> travelinfoList;
   SettravelInfos(List<TravelInfo>? infos){
    travelinfoList = infos!;
  }
}