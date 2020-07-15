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
      text: "Hello World, this message will be from Watson in due time.",
      user: ChatUser(name: "Watson"),
      createdAt: DateTime.now(),
    )
  ];

  void onSend(ChatMessage message, String sessionId) async {
    messages.add(message);
    var res = await http.post("$API_BASE/message", body: {
      "sessionId": sessionId,
      "text": message.text,
      "user": user.uid,
      "date": message.createdAt.toString()
    });
    setState(() {
      messages.add(
        ChatMessage(text: res.body, user: watson, createdAt: DateTime.now()),
      );
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
      scrollToBottom: true,
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
