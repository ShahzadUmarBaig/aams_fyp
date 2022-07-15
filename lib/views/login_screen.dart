import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoginScreen extends StatelessWidget {
  static const String id = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Employee Login",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24),
          ProfilePictureWidget(),
        ],
      ),
    );
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: Stack(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -8,
              bottom: 8,
              child: MaterialButton(
                onPressed: () async {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff3531EC),
                        Color(0xff873FA9),
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      // context
      //     .read<ProfileCompletionBloc>()
      //     .add(OnFileChanged(File(image.path)));
    }
  }
}
