import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();
  factory FirebaseService() {
    return _singleton;
  }
  FirebaseService._internal();
  User user = FirebaseAuth.instance.currentUser!;
}
