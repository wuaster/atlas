import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:provider/provider.dart';
import 'package:atlas/providers/session_provider.dart';

import 'package:atlas/globals.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ChatUser user = ChatUser(
    name: "Me",
    uid: "2",
  );
  final ChatUser watson = ChatUser(
    name: "Watson",
    uid: "1",
  );

  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hi, how can I help you today?",
      user: ChatUser(name: "Watson"),
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      text: "Here are some of the things you can ask from me:",
      user: ChatUser(name: "Watson"),
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      text:
          '- Add a trip\n- How much money have I saved?\n- What is my carbon footprint?',
      user: ChatUser(name: "Watson"),
      createdAt: DateTime.now(),
    ),
  ];

  void onSend(ChatMessage message, String sessionId) async {
    setState(() {
      messages = [...messages, message];
    });
    var res = await http.post("$API_BASE/message", body: {
      "sessionId": sessionId,
      "text": message.text,
      "user": user.uid,
      "date": message.createdAt.toString()
    });
    setState(() {
      messages = [
        ...messages,
        ChatMessage(text: res.body, user: watson, createdAt: DateTime.now())
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    String sessionId = context.watch<Session>().sessionId;
    return DashChat(
      showUserAvatar: false,
      sendOnEnter: true,
      textInputAction: TextInputAction.send,
      dateFormat: DateFormat('yyyy MMM dd'),
      scrollToBottom: false,
      inputDecoration:
          InputDecoration.collapsed(hintText: "Add message here..."),
      messagePadding: EdgeInsets.all(10),
      onSend: (ChatMessage message) {
        onSend(message, sessionId);
      },
      messages: messages,
      user: user,
    );
  }
}
