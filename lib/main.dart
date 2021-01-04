import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/login/signin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth user =  FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    if (user.currentUser != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignIn(),
      );
    }
    /*
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignIn(),
    );*/
  }
}
