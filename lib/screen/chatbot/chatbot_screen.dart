import 'package:dameyu_project/services/chatbot/chatbot_api.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService apiService = ApiService(Dio());
  List<String> messages = [];

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      messages.add('You: ${_controller.text}');
    });
    try {
      final responseMessage = await apiService.postChat(_controller.text);
      setState(() {
        messages.add('Bot: $responseMessage');
      });
    } catch (e) {
      setState(() {
        messages.add('Error: $e');
      });
    }
    _controller.clear();
  }

  void _loadChat() async {
    final response = await apiService.getChat();
    if (response.statusCode == 200) {
      setState(() {
        messages.add('Bot: ${response.data}');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}