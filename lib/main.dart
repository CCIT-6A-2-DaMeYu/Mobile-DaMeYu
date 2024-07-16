import 'package:dameyu_project/provider/login_provider.dart';
import 'package:dameyu_project/provider/user_provider.dart';
import 'package:dameyu_project/screen/chatbot/chatbot_screen.dart';
import 'package:dameyu_project/screen/login/login_screen.dart';
import 'package:dameyu_project/screen/navigation_bart.dart';
import 'package:dameyu_project/screen/result_predict/result_predict_screen.dart';
import 'package:dameyu_project/screen/splash_screen/splash_screen.dart';
import 'package:dameyu_project/services/result_predict/result_predict_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DaMeYu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:  const LoginScreen(),
    );
  }
}
