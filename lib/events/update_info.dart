import 'package:mute_help/model/info.dart';
import 'package:mute_help/events/info_event.dart';

import 'package:mute_help/model/travel_info.dart';

class UpdateInfo extends InfoEvent {
  static late Info newInfo;
  static late int infoIndex;

  UpdateInfo(int? index, Info? info) {
    newInfo = info!;
    infoIndex = index!;
  }
}

class UpdatetravelInfo extends InfoEvent {
  static late TravelInfo newtravelInfo;
  static late int travelinfoIndex;
  UpdatetravelInfo(int? index, TravelInfo? info) {
    newtravelInfo = info!;
    travelinfoIndex = index!;
  }
}
