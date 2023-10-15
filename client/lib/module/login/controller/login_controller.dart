import 'package:client/service/db_service/db_service.dart';
import 'package:client/state_util.dart';
import 'package:flutter/material.dart';
import 'package:client/core.dart';
import '../view/login_view.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  @override
  void initState() {
    instance = this;
    name = DBService.get("name") ?? "";
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  late String name;
  login() async {
    if (name.isNotEmpty) {
      Get.offAll(const ChatDetailView());
    }
  }
}
