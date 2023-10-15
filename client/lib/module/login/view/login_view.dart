import 'dart:math';

import 'package:client/service/db_service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:client/core.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: controller.name,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                helperText: "What's your name?",
              ),
              onChanged: (value) {
                controller.name = "${value}_${Random().nextInt(1000)}";
                DBService.set("name", controller.name);
              },
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 42,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () => controller.login(),
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
