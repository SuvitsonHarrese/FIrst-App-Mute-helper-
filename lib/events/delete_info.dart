import 'info_event.dart';
class DeleteInfo extends InfoEvent {
  static late  int infoIndex;
  
  DeleteInfo(int? index) {
    infoIndex = index!;
  }
   
}
class DeletetravelInfo extends InfoEvent{
  static late int travelinfoIndex;
  DeletetravelInfo(int? index) {
    travelinfoIndex = index!;
  }
}