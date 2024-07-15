import 'package:dameyu_project/services/chatbot/chatbot_api.dart';
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:dameyu_project/theme/theme_text_style.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart'; // Import the intl package for DateFormat

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatBotAPI chatBotAPI = ChatBotAPI(Dio());
  List<String> messages = [];
  List<bool> isBotMessages = [];
  List<DateTime> messageTimes = []; // List to hold timestamps for each message

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      messages.add(_controller.text);
      isBotMessages.add(false); // False indicates user message
      messageTimes.add(DateTime.now()); // Add current time as timestamp
    });
    try {
      final responseMessage = await chatBotAPI.postChatBot(_controller.text);
      final cleanedMessage = _cleanMessage(responseMessage);
      setState(() {
        messages.add(cleanedMessage);
        isBotMessages.add(true); // True indicates bot message
        messageTimes.add(DateTime.now()); // Add current time as timestamp
      });
    } catch (e) {
      setState(() {
        messages.add('Error: $e');
        isBotMessages.add(true); // Show error as bot message for consistency
        messageTimes.add(DateTime.now()); // Add current time as timestamp
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
        messageTimes.add(DateTime.now()); // Add current time as timestamp
      });
    }
  }

  String _cleanMessage(String message) {
    return message.replaceAll(RegExp(r'[{}]'), '').replaceAll('greeting', '').replaceAll(':', '').trim();
  }

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('HH:mm').format(timestamp); // Format timestamp as HH:mm
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
                    Transform.translate(
            offset: Offset(0, -5), // Geser hanya gambar ke atas
            child: Image.asset(
              'assets/chatbot.png',
              height: 30, // Sesuaikan tinggi gambar
            ),
          ),
                    const SizedBox(width: 10), // Spasi antara gambar dan teks
                    Text(
                      'ChatBot',
                      style: ThemeTextStyle().chatBotHeader,
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
                DateTime messageTime = messageTimes[index];
                return Align(
                  alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isBot)
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0, left: 3.0),
                           
                                child: Image.asset(
                                  'assets/chatbot.png', // Path to your asset image
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: ThemeColor().pink2Color,
                                  // color: isBot ? Colors.pink : Colors.pink,
                                  borderRadius: isBot
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.circular(14),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.zero,
                              ),
                                ),
                                constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7, // Batasi lebar maksimum
                      ),
                                child: Text(
                                  messages[index],
                                  style: ThemeTextStyle().chatBot,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5), // Space between message and timestamp
                       Text(
                          _formatTimestamp(messageTime),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
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
                      color: Colors.grey[300], // Grey background color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'What do you want to ask?',
                        hintStyle: ThemeTextStyle().chatBotText,
                        border: InputBorder.none, // Remove border
                        contentPadding: EdgeInsets.all(10), // Padding inside TextField
                      ),
                       
                    ),
                  ),
                ),
                SizedBox(width: 15), // Space between TextField and IconButton
                Card(
                  color: ThemeColor().pinkColor,
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
