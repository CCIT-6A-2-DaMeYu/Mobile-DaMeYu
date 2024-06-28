import 'package:flutter/material.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ChatBotScreen")),
      body: const Center(
        child: Text("ChatBotScreen Page Content"),
      ),
    );
  }
}