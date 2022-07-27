import 'package:aams_fyp/models/class.dart';
import 'package:aams_fyp/models/course.dart';
import 'package:aams_fyp/models/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();
  factory FirebaseService() {
    return _singleton;
  }
  FirebaseService._internal();
  User user = FirebaseAuth.instance.currentUser!;

  Future createUser({
    required String studentName,
    required String studentId,
    required String email,
  }) async {
    u.User localUser = u.User(
      studentId: studentId,
      email: email,
      studentName: studentName,
      uid: user.uid,
    );

    await FirebaseFirestore.instance.collection("users").add(localUser.toMap());
  }

  Stream<List<Course>> getAllCourses() {
    return FirebaseFirestore.instance.collection("courses").snapshots().map(
        (event) => event.docs.map((e) => Course.fromMap(e.data())).toList());
  }

  Stream<List<Class>> getAllClasses() {
    return FirebaseFirestore.instance.collection("classes").snapshots().map(
        (event) => event.docs.map((e) => Class.fromMap(e.data())).toList());
  }

  Future addCourse(
      {required String courseName,
      required String courseInstructor,
      required String courseClasses}) async {
    Course course = Course(
      courseName: courseName,
      courseInstructor: courseInstructor,
      courseClasses: int.parse(courseClasses),
    );

    await FirebaseFirestore.instance.collection("courses").add(course.toMap());
  }

  // create class function
  Future addClass({
    required String className,
    required DateTime classTime,
  }) async {
    Class classObject = Class(
      className: className,
      classTime: classTime,
    );

    await FirebaseFirestore.instance
        .collection("classes")
        .add(classObject.toMap());
  }
}
