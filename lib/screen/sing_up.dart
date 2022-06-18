import 'package:email_validator/email_validator.dart';
import 'package:fire_notes/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../style/app_style.dart';
import '../widgets/utils.dart';

class SingUpWidget extends StatefulWidget {
  const SingUpWidget({Key? key, required this.onClickedSingIn})
      : super(key: key);
  final Function() onClickedSingIn;

  @override
  State<SingUpWidget> createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: textFormFieldDecoration(
                        AppStyle.bgColor, "", "Email Adress"),
                    style: AppStyle.mainTile,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.name,
                    controller: passController,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: textFormFieldDecoration(
                        AppStyle.bgColor, "", "Password"),
                    style: AppStyle.mainTile,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min. 6 characters'
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: singUp,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      'Sing Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        text: 'Already have an account?  ',
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSingIn,
                            text: 'Sing In',
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

  Future singUp() async {
    final isValid = globalKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
