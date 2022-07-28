import 'package:aams_fyp/models/class.dart';

class Attendance {
  final String uid;
  final Class classObject;

  Attendance({required this.uid, required this.classObject});

  // create fromJson
  factory Attendance.fromMap(Map<String, dynamic> json) {
    return Attendance(
      uid: json["uid"],
      classObject: Class.fromMap(json["classData"]),
    );
  }

  //create toJson
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "classObject": classObject.toMap(),
      };
}
