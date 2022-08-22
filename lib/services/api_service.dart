import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';

final info = NetworkInfo();

class ApiService {
  final String faceRegisterMessage = "Face successfully registered";

  Future checkWifiName() async {
    var wifiName = await info.getWifiName(); // FooNetwork
    // var wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    // var wifiIP = await info.getWifiIP(); // 192.168.1.43
    // var wifiIPv6 =
    //     await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    // var wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
    // var wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
    // var wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1

    // if (wifiName != "Eduroam") {
    //   throw ApiException("Please connect to Eduroam wifi");
    // }

    return wifiName;
  }

  Future<String> registerUser(String studentID, String filePath) async {
    try {
      File file = File(filePath);
      double fileSize = file.lengthSync() / 1024 / 1024;
      if (fileSize > 2) {
        throw ApiException("File size must be smaller than 2MB");
      }

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://my-env.eba-mjj9b6wm.us-east-1.elasticbeanstalk.com/register'));
      request.fields.addAll({'empCode': '${studentID.trim()}'});
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      });
      http.StreamedResponse response = await request.send();
      String rawResponse = await response.stream.bytesToString();
      Map decodedResponse = json.decode(rawResponse);
      if (response.statusCode == 200) {
        return decodedResponse['response'];
      } else {

        throw ApiException(decodedResponse['error']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyUser(String studentId, String filePath) async {
    try {
      File file = File(filePath);
      double fileSize = file.lengthSync() / 1024 / 1024;
      if (fileSize > 2) {
        throw ApiException("File size must be smaller than 2MB");
      }
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://my-env.eba-mjj9b6wm.us-east-1.elasticbeanstalk.com/verify'));
      request.fields.addAll({'empCode': '${studentId.trim()}'});
      request.files
          .add(await http.MultipartFile.fromPath('image', '$filePath'));

      http.StreamedResponse response = await request.send();
      String rawResponse = await response.stream.bytesToString();
      Map decodedResponse = json.decode(rawResponse);
     if (response.statusCode == 200) {
        return decodedResponse['response'];
      } else {
        throw ApiException(decodedResponse['error']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signUpUser(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw ApiException(e.message ?? e.code);
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw ApiException(e.message ?? e.code);
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}
