import 'dart:convert';

import 'package:client/service/db_service/db_service.dart';
import 'package:client/state_util.dart';
import 'package:flutter/material.dart';
import 'package:client/core.dart';
import 'package:web_socket_channel/io.dart';
import '../view/chat_detail_view.dart';

class ChatDetailController extends State<ChatDetailView> {
  static late ChatDetailController instance;
  late ChatDetailView view;

  @override
  void initState() {
    instance = this;
    channel.stream.listen(
      (data) {
        setState(() {
          messages.add(jsonDecode(data));
        });
      },
      onDone: () {
        // WebSocket connection is closed
        print('WebSocket connection closed');
      },
      onError: (error) {
        // Handle any WebSocket errors here
        print('WebSocket error: $error');
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  final channel = IOWebSocketChannel.connect('ws://localhost:8080');
  final TextEditingController textEditingController = TextEditingController();
  final List<Map<String, dynamic>> messages = []; // List untuk menyimpan pesan
  FocusNode focusNode = FocusNode();

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      channel.sink.add(jsonEncode({
        "sender": DBService.get("name"),
        "message": text,
      }));
      textEditingController.clear();
      focusNode.requestFocus();
    }
  }

  doLogout() async {
    DBService.remove("name");
    Get.offAll(const LoginView());
  }
}
