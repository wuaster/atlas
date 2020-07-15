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
      quickReplies: QuickReplies(
        values: <Reply>[
          Reply(
            title: "Add trip",
            value: "Add a trip",
          ),
          Reply(
            title: "Record trip",
            value: "Record my trip",
          ),
          Reply(
            title: "Donate",
            value: "How can I donate?",
          ),
          Reply(
            title: "Money saved?",
            value: "How much money have I saved?",
          ),
          Reply(
            title: "Footprint?",
            value: "What's my carbon footprint?",
          ),
        ],
      ),
    ),
  ];

  void onSend(ChatMessage message, String sessionId) async {
    setState(() {
      messages = [...messages, message];
    });
    var res = await http.post(
      "$API_BASE/message",
      body: {
        "sessionId": sessionId,
        "text": message.text,
        "user": user.uid,
        "date": message.createdAt.toString()
      },
    );
    setState(() {
      messages = [
        ...messages,
        ChatMessage(text: res.body, user: watson, createdAt: DateTime.now())
      ];
    });
  }

  void onQuickReply(Reply reply, String sessionId) async {
    setState(() {
      messages.add(
        ChatMessage(
          text: reply.value,
          createdAt: DateTime.now(),
          user: user,
        ),
      );
    });
    var res = await http.post(
      "$API_BASE/message",
      body: {
        "sessionId": sessionId,
        "text": reply.value,
        "user": user.uid,
        "date": DateTime.now().toString()
      },
    );
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
      quickReplyScroll: true,
      quickReplyStyle: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      onQuickReply: (Reply reply) {
        onQuickReply(reply, sessionId);
      },
      quickReplyTextStyle: TextStyle(color: Colors.white),
      messages: messages,
      user: user,
    );
  }
}
