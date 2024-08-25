import 'package:firebase_core/firebase_core.dart'; // Import firebase_core dependency
import 'package:flutter/material.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // It's a need for the application to have these to work
  await Firebase.initializeApp(
    //add your project details by going to your project settings
    options: const FirebaseOptions(
        apiKey: "AIzaSyDH0oRKoBPjg-AVZ8Ju69hmUn8m7t3cZUQ",
        authDomain: "fir-assignment1-749a9.firebaseapp.com",
        projectId: "fir-assignment1-749a9",
        storageBucket: "fir-assignment1-749a9.appspot.com",
        messagingSenderId: "186519920076",
        appId: "1:186519920076:android:91fe19ce9b654834a29169"),
  );
  runApp(MyApp());
}

// Set the login page as the home page which the application starts with.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
