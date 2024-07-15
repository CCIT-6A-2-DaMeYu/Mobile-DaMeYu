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
        leading: IconButton(
    icon: Image.asset(
      'assets/back.png', // Ganti dengan path gambar Anda
      height: 24, // Sesuaikan tinggi gambar
      width: 24, // Sesuaikan lebar gambar
    ),
    onPressed: () {
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    },
  ),
  backgroundColor: Colors.white, // Menentukan warna latar belakang AppBar
  elevation: 3.0, // Menentukan elevasi AppBar
  shadowColor: Colors.grey.withOpacity(0.5), // Menentukan warna bayangan
  title: Stack(
    children: <Widget>[
      Align(
        alignment: Alignment.center,
        child: Transform.translate(
          offset: Offset(-30, 0), // Geser kiri atau kanan dengan mengganti nilai x
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/chatbot.png',
                height: 30, // Sesuaikan tinggi gambar
              ),
              const SizedBox(width: 10), // Spasi antara gambar dan teks
              const Text(
                'ChatBot',
                style: TextStyle(
                  fontSize: 20, // Menentukan ukuran font
                  fontWeight: FontWeight.bold, // Menentukan ketebalan font
                  color: Colors.pink, // Menentukan warna font
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),


      body: Column(
  children: <Widget>[
    const SizedBox(height: 15),
    Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          bool isBot = isBotMessages[index];
          return Align(
            alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isBot)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        'assets/chatbot.png', // Path ke gambar aset Anda
                        height: 30, // Sesuaikan ukuran gambar
                        width: 30, // Sesuaikan ukuran gambar
                      ),
                    ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isBot ? Colors.pink : Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Warna latar belakang abu-abu
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'What do you want to ask?',
              border: InputBorder.none, // Menghilangkan border
              contentPadding: EdgeInsets.all(10), // Padding di dalam TextField
            ),
          ),
        ),
      ),
      SizedBox(width:15), // Jarak antara TextField dan IconButton
           Card(
            color: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3.0,
        child: IconButton(
          icon: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: _sendMessage,
          
        ),
        
      ),
          
        ],
      ),
    ),
  ],
),




    );
  }
}
