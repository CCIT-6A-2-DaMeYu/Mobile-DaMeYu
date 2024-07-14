import 'package:dameyu_project/services/chatbot/chatbot_api.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatBotAPI chatBotAPI = ChatBotAPI(Dio());
  List<String> messages = [];

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      messages.add('You: ${_controller.text}');
    });
    try {
      final responseMessage = await chatBotAPI.postChatBot(_controller.text);
      final cleanedMessage = _cleanMessage(responseMessage);
      setState(() {
        messages.add('Bot: $cleanedMessage');
      });
    } catch (e) {
      setState(() {
        messages.add('Error: $e');
      });
    }
    _controller.clear();
  }

  void _loadChat() async {
    final response = await chatBotAPI.getChatBot();
    if (response.statusCode == 200) {
      final cleanedMessage = _cleanMessage(response.data.toString());
      setState(() {
        messages.add('Bot: $cleanedMessage');
      });
    }
  }

  String _cleanMessage(String message) {
    return message.replaceAll(RegExp(r'[{}]'), '').replaceAll('greeting', '').trim();
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
