import 'package:flutter/material.dart';

class MoreInfoPage extends StatefulWidget {
  @override
  _MoreInfoPageState createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
          IconButton(icon: Icon(Icons.analytics_outlined), onPressed: (){},),
          IconButton(icon: Icon(Icons.calendar_view_day_outlined), onPressed: (){},),
          IconButton(icon: Icon(Icons.group), onPressed: (){},),
          IconButton(icon: Icon(Icons.settings), onPressed: (){}),
        ],),),
      
    );
  }
}