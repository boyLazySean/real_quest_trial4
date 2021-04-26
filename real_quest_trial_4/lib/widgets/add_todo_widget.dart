import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_quest_trial_4/widgets/todo_form_widget.dart';
import 'package:real_quest_trial_4/model/todo.dart';
import 'package:real_quest_trial_4/provider/todos.dart';

class AddTodoWidget extends StatefulWidget {
  @override
  _AddTodoWidgetState createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => Padding(
        key: _formKey,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedTodo: addTodo),
          ],
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
      ;
    }
  }
}
