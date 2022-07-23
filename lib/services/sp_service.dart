import 'package:shared_preferences/shared_preferences.dart';

class SPService {
  static final SPService _singleton = SPService._internal();

  factory SPService() {
    return _singleton;
  }

  static const String kStudentCode = "student_code";

  SPService._internal();

  late SharedPreferences instance;

  init() async {
    instance = await SharedPreferences.getInstance();
  }

  Future setStudentCode(String studentCode) async {
    await instance.setString(kStudentCode, studentCode);
  }

  String getStudentCode() {
    return instance.getString(kStudentCode)!;
  }

  Future setData(String key, String value) async {
    await instance.setString(key, value);
  }
}
