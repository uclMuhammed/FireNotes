import 'package:fire_notes/screen/login_widget.dart';
import 'package:fire_notes/screen/sing_up.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  void toggle() => setState(() => isLogin = !isLogin);
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(onClickedSingUp: toggle)
      : SingUpWidget(onClickedSingIn: toggle);
}
