import 'dart:convert';
import 'package:dameyu_project/screen/chatbot/chatbot_screen.dart';
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ResultPredictScreen extends StatefulWidget {
  const ResultPredictScreen({super.key});

  @override
  _ResultPredictScreenState createState() => _ResultPredictScreenState();
}

class _ResultPredictScreenState extends State<ResultPredictScreen> {
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
      backgroundColor: ThemeColor().whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: ThemeColor().pinkColor,
          centerTitle: true,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/logo2.png',
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Image.asset('assets/chatbotbutton.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatBotScreen()),
                  );
                },
              ),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20), // Sesuaikan jarak dari atas sesuai kebutuhan
          Center(
            child: base64Image.isEmpty
                ? CircularProgressIndicator()
                : Card(
                  color: const Color(0xFFFFA0B5),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  width: 350, // Set your desired width
                  height: 260, // Set your desired height
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: imageFromBase64String(base64Image),
                ),
              ),
      ),
          ),
          // Spacer(), // Menambahkan spacer untuk mendorong widget lain ke bawah
        ],
      ),
    );
  }
}