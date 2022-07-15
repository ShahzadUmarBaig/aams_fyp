import 'package:http/http.dart' as http;

class ApiService {
  Future registerUser() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://my-env.eba-mjj9b6wm.us-east-1.elasticbeanstalk.com/register'));
    request.fields.addAll({'empCode': '123456'});
    request.files.add(await http.MultipartFile.fromPath(
        'image', '/home/asharib/Downloads/PS/222.jpg'));
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future loginUser() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://my-env.eba-mjj9b6wm.us-east-1.elasticbeanstalk.com/verify'));
    request.fields.addAll({'empCode': '123456'});
    request.files.add(await http.MultipartFile.fromPath('image',
        '/home/asharib/Pictures/Screenshot from 2022-05-12 20-27-00.png'));
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}
