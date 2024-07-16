import 'package:dameyu_project/services/chatbot/chatbot_api.dart';
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:dameyu_project/theme/theme_text_style.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';  // date format

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

  class _ChatBotScreenState extends State<ChatBotScreen> {
    final TextEditingController _controller = TextEditingController();
    final ChatBotAPI chatBotAPI = ChatBotAPI(Dio());
    List<String> messages = [];
    List<bool> isBotMessages = [];
    List<DateTime> messageTimes = []; // List to hold timestamps for each message
    final ScrollController _scrollController = ScrollController();

    void _sendMessage() async {
      if (_controller.text.isEmpty) return;
      setState(() {
        messages.add(_controller.text);
        isBotMessages.add(false); // False indicates user message
        messageTimes.add(DateTime.now()); // Add current time as timestamp
      });
      _scrollToBottom();
      try {
        final responseMessage = await chatBotAPI.postChatBot(_controller.text);
        final cleanedMessage = _cleanMessage(responseMessage);
        setState(() {
          messages.add(cleanedMessage);
          isBotMessages.add(true); // True indicates bot message
          messageTimes.add(DateTime.now()); // Add current time as timestamp
        });
        _scrollToBottom();
      } catch (e) {
        setState(() {
          messages.add('Error: $e');
          isBotMessages.add(true); // Show error as bot message for consistency
          messageTimes.add(DateTime.now()); // Add current time as timestamp
        });
        _scrollToBottom();
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
        _scrollToBottom();
      }
    }

    String _cleanMessage(String message) {
      return message.replaceAll(RegExp(r'[{}]'), '').replaceAll('greeting', '').replaceAll(':', '').trim();
    }

    String _formatTimestamp(DateTime timestamp) {
      return DateFormat('HH:mm').format(timestamp); 
    }

    void _scrollToBottom() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }

    @override
    void initState() {
      super.initState();
      _loadChat();
    }

    @override
    void dispose() {
      _scrollController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              'assets/back.png', 
              height: 24, 
              width: 24, 
            ),
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
          backgroundColor: Colors.white, 
          elevation: 3.0, 
          shadowColor: Colors.grey.withOpacity(0.5), 
          title: Stack(
            children: <Widget>[
              Align(
              alignment: Alignment.center,
                child: Transform.translate(
                  offset: Offset(-30, 0), 
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Transform.translate(
                        offset: const Offset(0, -5), 
                        child: Image.asset(
                          'assets/chatbot.png',
                          height: 30, 
                        ),
                      ),
                      const SizedBox(width: 10), 
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
                controller: _scrollController, // Attach ScrollController
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isBot = isBotMessages[index];
                  DateTime messageTime = messageTimes[index];
                  return Align(
                    alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
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
                                  'assets/chatbot.png', 
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    // color: ThemeColor().pink2Color,
                                    color: isBot ? const Color(0xFFFFCBCB) : const Color(0xFFEB6383),
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
                                  child:  Text(
                                    messages[index],
                                    textAlign: TextAlign.justify,
                                    style: isBot
                                    ? ThemeTextStyle().chatBot 
                                    : ThemeTextStyle().chatBot.copyWith(color: Colors.white), 
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5), 
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
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'What do you want to ask?',
                        hintStyle: ThemeTextStyle().chatBotText,
                        border: InputBorder.none, 
                        contentPadding: const EdgeInsets.all(10), 
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15), 
                Card(
                  color: ThemeColor().pinkColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3.0,
                  child: IconButton(
                    icon: const Icon(
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