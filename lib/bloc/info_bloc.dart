// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mute_help/events/set_info.dart';
import 'package:mute_help/model/info.dart';
import '../events/info_event.dart';
import 'package:mute_help/events/add_info.dart';
import 'package:mute_help/events/update_info.dart';
 import 'package:mute_help/events/delete_info.dart';
class InfoBloc extends Bloc<InfoEvent, List<Info>> {
  @override
  InfoBloc() : super([]) {
    on <AddInfo>(_addpolo);
    on <SetInfos>(_setpolo);
    on <UpdateInfo>(_updatepolo);
    on<DeleteInfo>(_deletepolo);
  }

  Future _setpolo(InfoEvent event,Emitter<List<Info>> emit)async{
    if (event is SetInfos) {
      emit (SetInfos.infoList);
    }
  }
  Future _addpolo(InfoEvent event,Emitter<List<Info>> emit)async{
    List<Info> newState = List.from(state);
    // newState.add(event.newInfo);
    if (AddInfo.newInfo != null) {
        newState.add(AddInfo.newInfo);
      }
      emit(newState);
  }
  Future _deletepolo(InfoEvent event,Emitter<List<Info>> emit)async{
    List<Info> newState = List.from(state);
      newState.removeAt(DeleteInfo.infoIndex);
      emit(newState);
  }
   Future _updatepolo(InfoEvent event,Emitter<List<Info>> emit)async{
    if (event is UpdateInfo) {
      List<Info> newState = List.from(state);
      newState[UpdateInfo.infoIndex] = UpdateInfo.newInfo;
      emit (newState);
    }
  }
  
}
