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
  List<bool> isBotMessages = [];

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      messages.add(_controller.text);
      isBotMessages.add(false); // False indicates user message
    });
    try {
      final responseMessage = await chatBotAPI.postChatBot(_controller.text);
      final cleanedMessage = _cleanMessage(responseMessage);
      setState(() {
        messages.add(cleanedMessage);
        isBotMessages.add(true); // True indicates bot message
      });
    } catch (e) {
      setState(() {
        messages.add('Error: $e');
        isBotMessages.add(true); // Show error as bot message for consistency
      });
    }
    _controller.clear();
  }

  void _loadChat() async {
    final response = await chatBotAPI.getChatBot();
    if (response.statusCode == 200) {
      final cleanedMessage = _cleanMessage(response.data.toString());
      setState(() {
        messages.add(cleanedMessage);
        isBotMessages.add(true); // Bot message
      });
    }
  }

  String _cleanMessage(String message) {
    return message.replaceAll(RegExp(r'[{}]'), '').replaceAll('greeting', '').replaceAll(':', '').trim();
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
        title: const Text(
          'Chatbot',
          style: TextStyle(
            fontSize: 20, // Menentukan ukuran font
            fontWeight: FontWeight.bold, // Menentukan ketebalan font
            color: Colors.pink, // Menentukan warna font
          ),
        ),
        
        centerTitle: true, // Menempatkan teks di tengah
        backgroundColor: Colors.white, // Menentukan warna latar belakang AppBar
        elevation: 3.0, // Menentukan elevasi AppBar
        shadowColor: Colors.grey.withOpacity(0.5), // Menentukan warna bayangan
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isBot = isBotMessages[index];
                return Align(
                  alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isBot ? Colors.pink: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      messages[index],
                      style: TextStyle(
                        color: isBot ? Colors.white : Colors.white,
                      ),
                    ),
                  ),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
