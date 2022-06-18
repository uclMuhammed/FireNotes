import 'package:fire_notes/screen/forgot_password_page.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:fire_notes/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
    required this.onClickedSingUp,
  }) : super(key: key);
  final VoidCallback onClickedSingUp;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.mainColor,
        body: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: textFormFieldDecoration(
                        AppStyle.bgColor, "", "Email Adress"),
                    style: AppStyle.mainTile,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.name,
                    controller: passController,
                    textInputAction: TextInputAction.done,
                    decoration: textFormFieldDecoration(
                        AppStyle.bgColor, "", "Password"),
                    style: AppStyle.mainTile,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: singIn,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      'Sing In',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()),
                    ),
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 18),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        text: 'No Account?  ',
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSingUp,
                            text: 'Sing Up',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future singIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  OutlineInputBorder textFormFieldBorderStyle(Color colorId) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      borderSide: BorderSide(color: AppStyle.bgColor),
    );
  }

  InputDecoration textFormFieldDecoration(
      Color colorId, String hint, String label) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      fillColor: AppStyle.bgColor,
      filled: true,
      enabledBorder: textFormFieldBorderStyle(colorId),
      disabledBorder: textFormFieldBorderStyle(colorId),
      border: textFormFieldBorderStyle(colorId),
      focusedBorder: textFormFieldBorderStyle(colorId),
    );
  }
}
