import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_quest_trial_4/provider/todos.dart';
import 'package:real_quest_trial_4/widgets/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
        ? Padding(
            padding: 
              EdgeInsets.symmetric(vertical: 20), 
            child: Center(
              child: Text(
                'No todos.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
        )

        : ListView.separated(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(10),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
            shrinkWrap: true,
          );
  }
}
