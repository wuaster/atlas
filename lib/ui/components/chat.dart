import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ChatUser user = ChatUser(
    name: "Me",
    uid: "2",
  );

  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hello World, this message will be from Watson in due time.",
      user: ChatUser(name: "Watson"),
      createdAt: DateTime.now(),
    )
  ];

  void onSend(ChatMessage message) async {
    print(message.toJson());
    messages.add(message);
    // send to backend
  }

  @override
  Widget build(BuildContext context) {
    return DashChat(
      showUserAvatar: false,
      sendOnEnter: true,
      textInputAction: TextInputAction.send,
      dateFormat: DateFormat('yyyy MMM dd'),
      scrollToBottom: true,
      inputDecoration:
          InputDecoration.collapsed(hintText: "Add message here..."),
      messagePadding: EdgeInsets.all(10),
      onSend: onSend,
      messages: messages,
      user: user,
    );
  }
}
