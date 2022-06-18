import 'package:email_validator/email_validator.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:fire_notes/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.mainColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStyle.mainColor,
          title: const Text("Reset Password"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Receive an email to\n reset your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: resetPassword,
                  icon: const Icon(Icons.email),
                  label: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar(
          "Password Reset Your ${emailController.text.toString()} E-mail Sent ");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
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
