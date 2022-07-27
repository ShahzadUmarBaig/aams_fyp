class User {
  final String studentId;
  final String email;
  final String studentName;
  final String uid;

  User({
    required this.studentId,
    required this.email,
    required this.studentName,
    required this.uid,
  });

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      uid: json["uid"],
      email: json["email"],
      studentId: json["studentId"],
      studentName: json["studentName"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "studentName": studentName,
      "studentId": studentId,
      "email": email,
    };
  }
}
