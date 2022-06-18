import 'package:fire_notes/firebase_options.dart';
import 'package:fire_notes/screen/auth_page.dart';
import 'package:fire_notes/screen/verify_email_page.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:fire_notes/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: Utils.messengerKey,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (contex, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: AppStyle.mainColor,
              body: const Center(child: CircularProgressIndicator()),
            );
          } else if (snapshots.hasError) {
            return Scaffold(
              backgroundColor: AppStyle.mainColor,
              body: const Center(child: Text('Something Went Wrong!')),
            );
          } else if (snapshots.hasData) {
            return const VerifyEmailPage();
          } else {
            return const AuthPage();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
