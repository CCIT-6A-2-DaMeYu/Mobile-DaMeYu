
// import 'package:dameyu_project/model/result_predict/result_predict_model.dart';
// import 'package:dameyu_project/screen/chatbot/chatbot_screen.dart';
// import 'package:dameyu_project/theme/theme_color.dart';
// import 'package:flutter/material.dart';

// class ResultPredictScreen extends StatefulWidget {
//   const ResultPredictScreen({super.key});

//   @override
//   State<ResultPredictScreen> createState() => _ResultPredictScreenState();
// }

// class _ResultPredictScreenState extends State<ResultPredictScreen> {

//   late Future<ResultPredictModel> _futureResult;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ThemeColor().whiteColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70.0),
//         child: AppBar(
//           backgroundColor: ThemeColor().pinkColor,
//           centerTitle: true,
//           title: Align(
//             alignment: Alignment.centerLeft,
//             child: Image.asset(
//               'assets/logo2.png',
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20.0),
//               child: IconButton(
//                 icon: Image.asset('assets/chatbotbutton.png'),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ChatBotScreen()),
//                   );
//                 },
//               ),
//             ),
//           ],
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(40),
//               bottomRight: Radius.circular(40),
//             ),
//           ),
//         ),
//       ),

//       body: FutureBuilder<ResultPredictModel>(
//         future: _futureResult,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final result = snapshot.data!;
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Estimasi: ${result.data.estimasi}'),
//                   Text('Kematangan: ${result.data.kematangan}'),
//                   Text('Status Code: ${result.status.code}'),
//                   Text('Pesan: ${result.status.message}'),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('Tidak ada data tersedia'));
//           }
//         },
//       ),
//     );
//   }
// }

      
//       // body: Padding(
//       //   padding: const EdgeInsets.all(30.0),
      
//       //   child: GridView.builder(
//       //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       //       crossAxisCount: 3, // 3 cards per row
//       //       crossAxisSpacing: 8.0,
//       //       mainAxisSpacing: 8.0,
//       //       childAspectRatio: 1.1, // Adjust as needed
//       //     ),
//       //     itemCount: 9, // Number of cards, you can adjust this
//       //     itemBuilder: (context, index) {
//       //      return Card(
//       //             color: const Color(0xFFFFA0B5),
                  
//       //             shape: RoundedRectangleBorder(
//       //               borderRadius: BorderRadius.circular(20),
//       //             ),
//       //             elevation: 3,
               
//       //           );
//       //     },
//       //   ),
//       // ),
// //     );
// //   }
// // }

// File: lib/screen/result_predict/result_predict_screen.dart
import 'package:dameyu_project/model/result_predict/result_predict_model.dart';
import 'package:dameyu_project/screen/chatbot/chatbot_screen.dart';
import 'package:dameyu_project/services/result_predict/result_predict_api.dart';
import 'package:dameyu_project/theme/theme_color.dart';

import 'package:flutter/material.dart';

class ResultPredictScreen extends StatefulWidget {
  const ResultPredictScreen({super.key});

  @override
  State<ResultPredictScreen> createState() => _ResultPredictScreenState();
}

class _ResultPredictScreenState extends State<ResultPredictScreen> {
  Future<ResultPredictModel>? _futureResult;

  @override
  void initState() {
    super.initState();
    _futureResult = ResultPredictApi().postResultPredict();
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
      body: FutureBuilder<ResultPredictModel>(
        future: _futureResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final result = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Estimation: ${result.data.estimation}'),
                  Text('Ripeness: ${result.data.ripeness}'),
                  Text('Status Code: ${result.status.code}'),
                  Text('Pesan: ${result.status.message}'),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Tidak ada data tersedia'));
          }
        },
      ),
    );
  }
}

