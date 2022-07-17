import 'package:mute_help/db/database_provider.dart';

class Info {
  int? id;
  String? name;
  String? email;
  String? dob;
  String? phoneNo;
  String? address;
  String? qualification;
  Info(
      {this.id,
      this.name,
      this.email,
      this.dob,
      this.phoneNo,
      this.address,
      this.qualification});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_DOB: dob,
      DatabaseProvider.COLUMN_PHONENO: phoneNo,
      DatabaseProvider.COLUMN_ADDRESS: address,
      DatabaseProvider.COLUMN_QUALIFICATION: qualification,
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    // print("ID value $id");
    return map;
  }

  Info.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    email = map[DatabaseProvider.COLUMN_EMAIL];
    dob = map[DatabaseProvider.COLUMN_DOB];
    phoneNo = map[DatabaseProvider.COLUMN_PHONENO];
    address = map[DatabaseProvider.COLUMN_ADDRESS];
    qualification = map[DatabaseProvider.COLUMN_QUALIFICATION];
  }
}
