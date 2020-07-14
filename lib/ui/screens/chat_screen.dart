import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DashChat(
          showUserAvatar: false,
          messageContainerDecoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          onSend: null,
          messages: [
            ChatMessage(
              text:
                  "Hello World, this message will be from Watson in due time.",
              user: ChatUser(name: "Watson"),
              createdAt: DateTime.now(),
            )
          ],
          user: ChatUser(name: "Me")),
    );
  }
}
