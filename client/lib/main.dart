import 'package:client/core.dart';
import 'package:client/service/db_service/db_service.dart';
import 'package:client/state_util.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.init();
  runApp(const ChatApp());
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  ChatAppState createState() => ChatAppState();
}

class ChatAppState extends State<ChatApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = DBService.get("name") != null;
    return MaterialApp(
      navigatorKey: Get.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const ChatDetailView() : const LoginView(),
    );
  }
}
