import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;
  final DateTime date;
  final TimeOfDay time;

  const TodoFormWidget({
    Key key,
    this.title = '',
    this.description = '',
    this.date,
    this.time,
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 2),
            buildDescription(),
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
                        }),
                    IconButton(icon: Icon(Icons.more_time), onPressed: () {}),
                    Spacer(),
                    TextButton(
                      child: Text('Save'),
                      onPressed: onSavedTodo,
                      // Navigator.of(context).pop();
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration:
            InputDecoration(border: UnderlineInputBorder(), labelText: 'Title'),
      );

        Widget buildDescription() => TextFormField(
        maxLines: 1,
        initialValue: description,
        onChanged: onChangedDescription,
        decoration:
            InputDecoration(border: UnderlineInputBorder(), labelText: 'Description'),
      );

  Future<void> showDateDialog(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      helpText: 'Select a Date',
    );
  }

}

// Future<void> showTimeDialog(BuildContext context) async {
//   final newTime = await showTimePicker(
//     context: context,
//     initialTime: time,
//   );
// }


