import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:provider/provider.dart';
import 'package:atlas/providers/session_provider.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:atlas/globals.dart';
import 'package:http/http.dart' as http;
import 'package:atlas/controllers/localstorage.dart';
import 'package:atlas/controllers/moneyservice.dart';
import 'package:atlas/controllers/emissionservice.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  MoneyService _moneyService;
  EmissionService _emissionService;

  @override
  void initState() {
    super.initState();
    context.read<Session>().getSessionId();
    _moneyService = MoneyService(
        localStorageRepository: LocalStorageRepository("money.json"));
    _emissionService = EmissionService(
      localStorageRepository: LocalStorageRepository("emissions.json"));
  }
  Future<void> _addMoney(double money) async {
    final double _newMoney = await _moneyService.saveMoney(money);
  }
  Future<void> _addEmissions(int emissions) async {
    final int _newEmissions = await _emissionService.saveEmissions(emissions);
  }
  
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
      text: "Hi, Watson here, how can I help you today?",
      user: ChatUser(name: "Watson"),
      createdAt: DateTime.now(),
      quickReplies: QuickReplies(
        values: <Reply>[
          Reply(
            title: "Add trip 📍",
            value: "Add a trip",
          ),
          Reply(
            title: "Record trip 🏁",
            value: "Record my trip",
          ),
          Reply(
            title: "Donate 🤩",
            value: "How can I donate?",
          ),
          Reply(
            title: "Saved 💰?",
            value: "How much money have I saved?",
          ),
          Reply(
            title: "Carbon 🦶?",
            value: "What's my carbon footprint?",
          ),
        ],
      ),
    ),
  ];

  String prepareJSON(String res) {
    Map<String, dynamic> body = jsonDecode(res);
    double money = body['dollars'];
    double distance = body['distance'];
    int efficiency = (body['efficiency']*100).round();
    double price = body['price'];
    int emission = body['emission'].round();
    String return_message = "Congratulations! You saved \$"+ money.toString() +" by not driving! 🎉 \n\nThat’s "+ emission.toString() +" kg of CO2 saved from entering the atmosphere!\n\nWith a distance of "+ distance.toString() +"km between the two locations, I assumed an efficiency of 11L/100km and a gas price of \$0.9/L.";
    _addMoney(money);
    _addEmissions(emission);
    return(return_message);
  }

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
    String result = res.body;
    if (res.body[0] =='{' && res.body[res.body.length-1] == '}'){
      result = prepareJSON(res.body);
    }
    
    setState(() {
      messages = [
        ...messages,
        ChatMessage(text: result, user: watson, createdAt: DateTime.now())
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
        borderRadius: BorderRadius.all(Radius.circular(4)),
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
