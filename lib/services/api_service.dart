import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String faceRegisterMessage = "Face successfully registered";

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
      request.fields.addAll({'empCode': '$studentID'});
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      });
      http.StreamedResponse response = await request.send();
      String rawResponse = await response.stream.bytesToString();
      Map decodedResponse = json.decode(rawResponse);
      print(response.statusCode);
      print(response.reasonPhrase);
      print(decodedResponse);
      print(rawResponse);
      if (response.statusCode == 200) {
        return decodedResponse['response'];
      } else {
        print("Coming here");
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
      request.fields.addAll({'empCode': '$studentId'});
      request.files
          .add(await http.MultipartFile.fromPath('image', '$filePath'));

      http.StreamedResponse response = await request.send();
      String rawResponse = await response.stream.bytesToString();
      Map decodedResponse = json.decode(rawResponse);
      print(response.statusCode);
      print(response.reasonPhrase);
      print(decodedResponse);
      print(rawResponse);
      if (response.statusCode == 200) {
        return decodedResponse['response'];
      } else {
        print("Coming here");
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
      throw ApiException(e.code);
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      rethrow;
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}
