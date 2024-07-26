import 'dart:convert';
import 'package:dameyu_project/model/result_predict/result_predict_model.dart';
import 'package:dameyu_project/screen/chatbot/chatbot_screen.dart';
import 'package:dameyu_project/services/result_predict/result_predict_api.dart';
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:dameyu_project/theme/theme_text_style.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ResultPredictScreen extends StatefulWidget {
  const ResultPredictScreen({super.key});

  @override
  _ResultPredictScreenState createState() => _ResultPredictScreenState();
}

class _ResultPredictScreenState extends State<ResultPredictScreen> {
  Future<ResultPredictModel>? _futureResult;
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
    DatabaseReference imageRef = FirebaseDatabase.instance.ref().child('image');

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

  // Function to make the POST request and get the prediction result
  Future<ResultPredictModel> postResultPredict() {
    return ResultPredictApi().postResultPredict();
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

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
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

          SizedBox(height: 20), // Add spacing between card and button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _futureResult = postResultPredict();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColor().pinkColor, // Set button color
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
             child: Text(
              'Apple Prediction',
              style: ThemeTextStyle().applePredict,
            ),
          ),
          const SizedBox(height: 20), // Add spacing between button and result card

          // Result card
          if (_futureResult != null)
            FutureBuilder<ResultPredictModel>(
              future: _futureResult,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final result = snapshot.data!;
                  return Center(
                    child: Card(
                      color: const Color(0xFFFFA0B5),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SizedBox(
                        width: 250, // Set your desired width
                        height: 100, // Set your desired height
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                'Estimation : ${result.data.estimation} Day',
                                style: ThemeTextStyle().resultPredict,
                              ),
                              Text('Ripeness    : ${result.data.ripeness}',
                              style: ThemeTextStyle().resultPredict,
                              ),
                              // Text('Status Code: ${result.status.code}'),
                              // Text('Pesan: ${result.status.message}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('Tidak ada data tersedia'));
                }
              },
            ),
        ],
      ),
    );
  }
}