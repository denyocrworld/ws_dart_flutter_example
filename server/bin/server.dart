import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

void main() async {
  final handler = webSocketHandler((webSocket) {
    webSocket.stream.listen((json) {
      var obj = jsonDecode(json);
      var message = obj["message"];
      var sender = obj["sender"];
      webSocket.sink.add(json);

      print('Received message: $message');

      // //auto reply
      if (message.toString().length < 5) {
        Future.delayed(Duration(milliseconds: 1500), () {
          webSocket.sink.add(jsonEncode({
            "sender": "BOT",
            "message":
                "Lagi males ngetik bang? cuman ngirim $message itu doang",
          }));
        });
      }
    });
  });

  final server = await shelf_io.serve(handler, 'localhost', 8080);

  print('WebSocket server started on port ${server.port}');
}
