import 'package:aams_fyp/models/attendance.dart';
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

  Future createUser({
    required String studentName,
    required String studentId,
    required String email,
  }) async {
    u.User localUser = u.User(
      studentId: studentId,
      email: email,
      studentName: studentName,
      uid: FirebaseAuth.instance.currentUser!.uid,
    );

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(localUser.toMap());
  }

  Stream<List<Course>> getAllCourses() {
    return FirebaseFirestore.instance.collection("courses").snapshots().map(
        (event) => event.docs.map((e) => Course.fromMap(e.data())).toList());
  }

  Stream<List<Class>> getAllClasses() {
    return FirebaseFirestore.instance.collection("classes").snapshots().map(
        (event) => event.docs.map((e) => Class.fromMap(e.data())).toList());
  }

  Future addCourse({
    required String courseName,
    required String courseInstructor,
    required String courseClasses,
  }) async {
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
    required DateTime startTime,
    required DateTime endTime,
    required Duration duration,
    required String courseName,
  }) async {
    Class classObject = Class(
      className: className,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      courseName: courseName,
    );

    await FirebaseFirestore.instance
        .collection("classes")
        .add(classObject.toMap());
  }

  // create stream that gets all attendance where uid is user.uid
  Stream<List<Attendance>> getAllAttendance() {
    print(FirebaseAuth.instance.currentUser!.uid);
    return FirebaseFirestore.instance
        .collection("attendance")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Attendance.fromMap(e.data())).toList());
  }

  // create attendance based on class object
  Future addAttendance({
    required Class classObject,
  }) async {
    await FirebaseFirestore.instance.collection("attendance").add({
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "classData": classObject.toMap(),
    });
  }

  //write user stream function
  Stream<u.User> userStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map(
          (event) => u.User.fromMap(event.data()!),
        );
  }
}
