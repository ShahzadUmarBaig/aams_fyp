import 'package:equatable/equatable.dart';

class Class extends Equatable {
  final String className;
  final String courseName;
  final DateTime startTime;
  final DateTime endTime;
  final Duration duration;
  final String uid;

  Class({
    required this.className,
    required this.courseName,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.uid,
  });

  factory Class.fromMap(Map<String, dynamic> json) {
    return Class(
      className: json["className"],
      courseName: json["courseName"],
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
      duration: Duration(milliseconds: json["duration"]),
      uid: json["uid"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "className": className,
      "courseName": courseName,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "duration": duration.inMilliseconds,
      "uid": uid,
    };
  }

  @override
  List<Object?> get props =>
      [className, courseName, startTime, endTime, duration, uid];
}
