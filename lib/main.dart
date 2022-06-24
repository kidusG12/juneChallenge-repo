import 'package:flutter/material.dart';
import 'package:flutterchallenge1/screens/login/login.dart';
import 'package:flutterchallenge1/screens/signup/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'june challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupScreen(),
      routes: {
        SignupScreen.routeName: (ctx)=>SignupScreen(),
        LoginScreen.routeName:(ctx)=>LoginScreen(),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx)=>SignupScreen());
      },
    );
  }
}

