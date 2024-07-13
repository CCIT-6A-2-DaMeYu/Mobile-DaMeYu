
// import 'dart:convert';

// import 'package:dameyu_project/theme/theme_color.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class ResultPredictScreen extends StatefulWidget {
//   const ResultPredictScreen({super.key});

//   @override
//   State<ResultPredictScreen> createState() => _ResultPredictScreenState();
// }

// class _ResultPredictScreenState extends State<ResultPredictScreen> {
//   Future<ResultPredictModel>? _futureResult;

//   @override
//   void initState() {
//     super.initState();
//     _futureResult = ResultPredictApi().postResultPredict();
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
//                     MaterialPageRoute(builder: (context) => ChatBotScreen()),
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
//                   Text('Estimation: ${result.data.estimation}'),
//                   Text('Ripeness: ${result.data.ripeness}'),
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

