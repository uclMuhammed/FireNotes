import 'dart:async';

import 'package:fire_notes/screen/home_screen.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:fire_notes/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    super.initState();
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
      await user.sendEmailVerification();
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const TabBarHomeScreen()
      : Scaffold(
          backgroundColor: AppStyle.mainColor,
          appBar: AppBar(
            backgroundColor: AppStyle.mainColor,
            title: const Text("Verify Email"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "A verification email has been sent to  your email.",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                  icon: const Icon(
                    Icons.email,
                    size: 24,
                  ),
                  label: const Text("Resend Email"),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            ),
          ),
        );
}
