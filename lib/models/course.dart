import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final int courseClasses;
  final String courseName;
  final String courseInstructor;

  Course({
    required this.courseClasses,
    required this.courseName,
    required this.courseInstructor,
  });

  factory Course.fromMap(Map<String, dynamic> json) {
    return Course(
      courseClasses: json["courseClasses"],
      courseName: json["courseName"],
      courseInstructor: json["courseInstructor"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "courseClasses": courseClasses,
      "courseName": courseName,
      "courseInstructor": courseInstructor,
    };
  }

  @override
  List<Object?> get props => [
        courseClasses,
        courseName,
        courseInstructor,
      ];
}
