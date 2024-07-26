import 'package:dameyu_project/screen/splash_screen/splash_screen.dart';
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:dameyu_project/theme/theme_text_style.dart';
import 'package:dameyu_project/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   String _username = "";
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profile_image', image.path);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
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
          title: Align(
  alignment: Alignment.centerLeft,
  child: Container(
    margin: const EdgeInsets.only(left: 20.0), // Adjust the value to move it to the right
    child: Image.asset(
      'assets/logo2.png',
    ),
  ),
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
                // ignore: unnecessary_string_interpolations
                '$_username',
                style: ThemeTextStyle().profile,
              ),
            ),
          ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor().pinkColor, // Warna latar belakang tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              ),
              child: Text(
                'Change Profile Picture',
                style: ThemeTextStyle().changeProfile, // Gaya teks untuk tombol
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 170),
            
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
                style: ThemeTextStyle().login, // Gaya teks untuk tombol logout
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor().pinkColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 7.0),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
