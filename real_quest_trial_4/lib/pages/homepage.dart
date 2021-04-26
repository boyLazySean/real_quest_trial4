import 'package:flutter/material.dart';
import 'package:real_quest_trial_4/widgets/add_todo_widget.dart';
import 'package:real_quest_trial_4/widgets/todo_list_widget.dart';
import 'package:real_quest_trial_4/widgets/completed_list_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  // Sliding up Panel 설정
  ScrollController scrollController;

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 85.0;

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
      ),

      //FAB 설정
      floatingActionButton: InkWell(
        splashColor: Colors.blue,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 35,
          ),
          mini: true,
          onPressed: ()=>showModalBottomSheet(
            isScrollControlled: true,
            elevation: 5,
            context: context, 
            builder: (context) => AddTodoWidget(),)
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,

      //Sliding up Panel UI 설정
      body: SlidingUpPanel(
        margin: EdgeInsets.only(left: 15, right: 15),
        maxHeight: _panelHeightOpen,
        minHeight: _panelHeightClosed,
        parallaxEnabled: true,
        parallaxOffset: .5,
        body: _body(),
        panelBuilder: (sc) => _panel(sc),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
        onPanelSlide: (double pos) => setState(() {
          _fabHeight =
              pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
        }),
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ))
              ],
            ),
            TodoListWidget(),
            ExpansionTile(title: Text('Completed'), initiallyExpanded: false, children: [CompletedListWidget()],)
          ],
        ),
    );
  }

  Widget _body() {
    return Container();
  }
}