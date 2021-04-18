import 'package:flutter/material.dart';
import 'package:real_quest_trial_4/mainPage.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter RQ Trial',
      theme: ThemeData(),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), openMainPage);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    )));
  }

  void openMainPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
