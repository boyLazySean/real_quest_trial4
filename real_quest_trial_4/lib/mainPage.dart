import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';

//Todo 클래스
class Todo {
  int id;
  String title;
  var date;
  var time;
  bool isDone;

  Todo(this.title, this.date, this.time, {this.isDone = false});
}

// 변수들
int _numTodo = 0;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: mainPage(),
    );
  }
}

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  // Sliding up Panel 설정
  ScrollController scrollController;

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
  }

  //Todo methods 설정
  final _items = <Todo>[];

  var _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = '';
      _numTodo++;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  /* 
  void _toggleTodo(Todo todo){
    setState((){
      todo.isDone = !todo.isDone;
    });
    }
  */

  //Date and Time Picker 설정
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future<void> showDateDialog(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      helpText: 'Select a Date',
    );
    if (newDate != null && newDate != _date) {
      setState(() {
        _date = newDate;
      });
    }
  }

  Future<void> showTimeDialog() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

//메인 화면 UI
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
        onLongPress: () {
          _routinePopUpScreen(context);
        },
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 35,
          ),
          mini: true,
          onPressed: () {
            _taskPopUpScreen(context);
          },
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

  //Sliding up Panel Widgets
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
            ListView.separated(
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, todo) {
                if (_numTodo == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        height: 25,
                        color: Colors.white.withOpacity(1.0),
                      ),
                      Text('Nothing to Do Today!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  );
                } else {
                  return ListBody(
                      children: _items
                          .map((todo) => _buildItemWidget(todo))
                          .toList());
                }
              },
              separatorBuilder: (context, todo) {
                return Divider(
                  color: Colors.grey,
                  height: 0.1,
                );
              },
              shrinkWrap: true,
              itemCount: 1,
            ),
          ],
        ));
  }

  Widget _body() {
    return Container();
  }

//Todo 항목 생성 위젯
  Widget _buildItemWidget(Todo todo) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.white,
      value: todo.isDone,
      isThreeLine: true,
      title: Text(
        todo.title,
        style: TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        DateFormat('MM월 dd일').format(todo.date),
        style: TextStyle(fontSize: 15),
      ),
      onChanged: (bool isDone) {
        setState(() {
          todo.isDone = isDone;
          _deleteTodo(todo);
        });
      },
    );
  }

  void _taskPopUpScreen(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _todoController,
              keyboardType: TextInputType.text,
              autofocus: true,
              cursorHeight: 25,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.check_circle_outline),
                hintText: 'Add a New Task',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 18),
            ),
            Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.today),
                      onPressed: () {
                        showDateDialog(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.more_time),
                      onPressed: () {
                        showTimeDialog();
                      },
                    ),
                    Spacer(),
                    TextButton(
                      child: Text('Save'),
                      onPressed: () {
                        _addTodo(
                          Todo(_todoController.text, _date, _time),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _routinePopUpScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.schedule),
                title: new Text('Add a New Routine'),
                onTap: () {
                  _addRoutineScreen(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.people_rounded),
                title: new Text('Add a New Team-Goal'),
                onTap: () {
                  _addTeamGoalScreen(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addRoutineScreen(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              autofocus: true,
              cursorHeight: 25,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.check_circle_outline),
                hintText: 'Add a New Routine',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 18),
            ),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.notes),
                    hintText: 'Description',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 18),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.today),
                      onPressed: () {
                        showDateDialog(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.more_time),
                      onPressed: () {
                        showTimeDialog();
                      },
                    ),
                    TextButton(
                      child: Text('Save'),
                      onPressed: () {},
                    ),
                  ],
                ),
                Divider(),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: [
                    ChoiceChip(
                      label: Text('#Health'),
                      selected: true,
                    ),
                    ChoiceChip(
                      label: Text('#Knowledge'),
                      selected: false,
                    ),
                    ChoiceChip(
                      label: Text('#Wellness'),
                      selected: false,
                    ),
                    ChoiceChip(
                      label: Text('#Motivation'),
                      selected: false,
                    ),
                    ChoiceChip(
                      label: Text('#Morning'),
                      selected: false,
                    ),
                    ChoiceChip(
                      label: Text('#Night'),
                      selected: false,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addTeamGoalScreen(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              autofocus: true,
              cursorHeight: 25,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.check_circle_outline),
                hintText: 'Add a New Team-Goal',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 18),
            ),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.notes),
                    hintText: 'Description',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 18),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.today),
                      onPressed: () {
                        showDateDialog(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.more_time),
                      onPressed: () {
                        showTimeDialog();
                      },
                    ),
                    TextButton(
                      child: Text('Save'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
