import 'package:flutter/material.dart';
import 'package:real_quest_trial_4/pages/homepage.dart';

class MoreInfoPage extends StatefulWidget {
  @override
  _MoreInfoPageState createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text('More Information', style: TextStyle(color: Colors.black)),
        leading: BackButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        color: Colors.black,
        ),     
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            IconButton(
              icon: Icon(Icons.analytics_outlined),
              onPressed: () {},
            ),
            Spacer(flex: 2),
            IconButton(
              icon: Icon(Icons.calendar_view_day_outlined),
              onPressed: () {},
            ),
            Spacer(flex: 2),
            IconButton(
              icon: Icon(Icons.group),
              onPressed: () {},
            ),
            Spacer(flex: 2),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
