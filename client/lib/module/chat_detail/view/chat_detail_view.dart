import 'package:client/service/db_service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:client/core.dart';
import '../controller/chat_detail_controller.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({Key? key}) : super(key: key);

  Widget build(context, ChatDetailController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () => controller.doLogout(),
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = controller.messages[index];
                  bool isMe = item["sender"] == DBService.get("name");
                  return Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["sender"],
                            style: const TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 12.0,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isMe ? Colors.grey[300] : Colors.green[100],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Text(
                              item["message"],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            TextField(
              controller: controller.textEditingController,
              focusNode: controller.focusNode,
              onSubmitted: controller.sendMessage,
              decoration: const InputDecoration(
                labelText: 'Send a message...',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<ChatDetailView> createState() => ChatDetailController();
}
