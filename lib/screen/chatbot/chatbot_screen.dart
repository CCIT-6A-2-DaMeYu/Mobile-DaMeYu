import 'package:dameyu_project/services/chatbot/chatbot_api.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService apiService = ApiService(Dio());
  List<String> messages = [];

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      messages.add('You: ${_controller.text}');
    });
    try {
      final response = await apiService.postChat(_controller.text);
      if (response.statusCode == 200) {
        setState(() {
          messages.add('Bot: ${response.data}');
        });
      } else {
        setState(() {
          messages.add('Error: ${response.statusMessage}');
        });
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data is String && e.response?.data.contains('<html>')) {
          setState(() {
            messages.add('Error: Received HTML response. Possible server error or wrong endpoint.');
          });
        } else {
          setState(() {
            messages.add('Error: ${e.response?.data}');
          });
        }
      } else {
        setState(() {
          messages.add('Error: $e');
        });
      }
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