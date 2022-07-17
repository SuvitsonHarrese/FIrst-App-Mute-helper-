// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mute_help/events/set_info.dart';
import 'package:mute_help/model/travel_info.dart';
import '../events/info_event.dart';
import 'package:mute_help/events/add_info.dart';
import 'package:mute_help/events/update_info.dart';
 import 'package:mute_help/events/delete_info.dart';

 class TravelInfoBloc extends Bloc<InfoEvent,List<TravelInfo>>{
  @override
  TravelInfoBloc() : super([]) {
    on <AddtravelInfo>(_addpolo);
    on <SettravelInfos>(_setpolo);
    on <UpdatetravelInfo>(_updatepolo);
    on<DeletetravelInfo>(_deletepolo);
  }
  Future _setpolo(InfoEvent event,Emitter<List<TravelInfo>> emit)async{
    if (event is SettravelInfos) {
      emit (SettravelInfos.travelinfoList);
    }
  }
  Future _addpolo(InfoEvent event,Emitter<List<TravelInfo>> emit)async{
    List<TravelInfo> newState = List.from(state);
    // newState.add(event.newInfo);
    if (AddtravelInfo.newtravelInfo != null) {
        newState.add(AddtravelInfo.newtravelInfo);
      }
      emit(newState);
  }
  Future _deletepolo(InfoEvent event,Emitter<List<TravelInfo>> emit)async{
    List<TravelInfo> newState = List.from(state);
      newState.removeAt(DeletetravelInfo.travelinfoIndex);
      emit(newState);
  }
   Future _updatepolo(InfoEvent event,Emitter<List<TravelInfo>> emit)async{
    if (event is UpdatetravelInfo) {
      List<TravelInfo> newState = List.from(state);
      newState[UpdatetravelInfo.travelinfoIndex] = UpdatetravelInfo.newtravelInfo;
      emit (newState);
    }
  }
 } 