import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atlas/ui/components/chat.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chat(),
    );
  }
}
