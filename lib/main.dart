import 'package:comanda_01/pages/userPage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:comanda_01/navigation/widgetTree.dart';
import 'package:comanda_01/pages/newOrder.dart';
import 'package:comanda_01/pages/loginRegisterPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    print("WEB");
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBkBi1VuZb8a1Ee-9eoBpagwj-nOrHjbdM",
            authDomain: "comanda-01-f2c43.firebaseapp.com",
            projectId: "comanda-01-f2c43",
            storageBucket: "comanda-01-f2c43.firebasestorage.app",
            messagingSenderId: "576560843684",
            appId: "1:576560843684:web:72c9a5028f9662bc6f4f31"));
  } else {
    print("MOBILE");
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'newOrder': (context) => const NewOrder(),
        'userPage': (context) => const UserPage(),
        '/loginRegisterPage': (context) => const LoginPage(),
      },
      home: const WidgetTree(),
    );
  }
}