
import 'dart:convert';

import 'package:dameyu_project/theme/theme_color.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ImageFromFirebaseRTDB extends StatefulWidget {
  @override
  _ImageFromFirebaseRTDBState createState() => _ImageFromFirebaseRTDBState();
}

class _ImageFromFirebaseRTDBState extends State<ImageFromFirebaseRTDB> {
  String base64Image = ""; // State to hold the base64 image string

  // Function to decode base64 string to image widget
  Widget imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }

  // Function to fetch data from Firebase RTDB
  void getImageData() async {
    DatabaseReference imageRef =
        FirebaseDatabase.instance.ref().child('image');

    imageRef.onValue.listen(
      (event) {
        var snapshot = event.snapshot;
        var value = snapshot.value as String?;

        if (value != null) {
          setState(() {
            base64Image = value;
          });
        } else {
          // Handle null or missing data case
          print('Snapshot value is null or not a string.');
        }
      },
      onError: (error) {
        print('Error fetching image data: $error');
      },
    );
  }


  @override
  void initState() {
    super.initState();
    getImageData(); // Fetch initial image data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coba Base 64 Image'),
      ),
      body: Center(
        child: base64Image.isEmpty
            ? CircularProgressIndicator()
            : imageFromBase64String(base64Image),
      ),
    );
  }
}

