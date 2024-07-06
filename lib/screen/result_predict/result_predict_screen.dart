
import 'package:dameyu_project/screen/chatbot/chatbot_screen.dart';
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:flutter/material.dart';

class ResultPredictScreen extends StatefulWidget {
  const ResultPredictScreen({super.key});

  @override
  State<ResultPredictScreen> createState() => _ResultPredictScreenState();
}

class _ResultPredictScreenState extends State<ResultPredictScreen> {
  @override
  void initState() {
    super.initState();
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
                    MaterialPageRoute(builder: (context) => const ChatBotScreen()),
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

      
      // body: Padding(
      //   padding: const EdgeInsets.all(30.0),
      
      //   child: GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 3, // 3 cards per row
      //       crossAxisSpacing: 8.0,
      //       mainAxisSpacing: 8.0,
      //       childAspectRatio: 1.1, // Adjust as needed
      //     ),
      //     itemCount: 9, // Number of cards, you can adjust this
      //     itemBuilder: (context, index) {
      //      return Card(
      //             color: const Color(0xFFFFA0B5),
                  
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //             elevation: 3,
               
      //           );
      //     },
      //   ),
      // ),
    );
  }
}
