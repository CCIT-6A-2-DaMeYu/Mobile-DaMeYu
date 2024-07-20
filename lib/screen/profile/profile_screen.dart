import 'package:dameyu_project/screen/splash_screen/splash_screen.dart';
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:dameyu_project/theme/theme_text_style.dart';
import 'package:dameyu_project/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

    String _username = "";
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsername().then((username) {
      if (mounted) {
        setState(() {
          _username = username;
        });
      }
    });
  }

  Future<String> _getUsername() async {
    final username = await SharedPref().getToken();
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: ThemeColor().whiteColor,
  appBar: PreferredSize(
    preferredSize: const Size.fromHeight(70.0),
    child: AppBar(
      backgroundColor: ThemeColor().pinkColor,
      centerTitle: true,
      title: Row(
        children: [
          // Logo
          Image.asset(
            'assets/logo2.png',
            width: 50, // Atur lebar logo sesuai kebutuhan
            height: 50, // Atur tinggi logo sesuai kebutuhan
          ),
          // Spacer to push title to the center
          Spacer(),
          // Title
          Text(
            'Profile',
            style: ThemeTextStyle().login, // Gaya teks untuk judul
          ),
          // Spacer to ensure the title is centered
          Spacer(),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    ),
  ),
      
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _profileImage != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_profileImage!),
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundColor: ThemeColor().greyColor,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: ThemeColor().whiteColor),
                      onPressed: _pickImage,
                    ),
                  ),

                  SizedBox(height: 20),

                  Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Username : $_username',
                style: ThemeTextStyle().welcomeUsername,
              ),
            ),
          ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SplashScreen(),
                  ),
                  (route) => false,
                );
                await SharedPref().removeToken();
              },
              child: Text(
                'Logout',
                style: ThemeTextStyle().login,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor().pinkColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 7.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
