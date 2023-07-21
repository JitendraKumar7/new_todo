import 'package:app/model/todo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../bloc/app_service.dart';

class TaskDetailPage extends StatelessWidget {
  final TodoModel model;

  const TaskDetailPage(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        centerTitle: false,
      ),
      body: ListView(padding: const EdgeInsets.all(9), children: [
        const Padding(
          padding: EdgeInsets.all(9),
          child: Text(
            'Title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(9),
          child: Text(model.title ?? ''),
        ),
        const Padding(
          padding: EdgeInsets.all(9),
          child: Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(9),
          child: Text(model.description ?? ''),
        ),
        const Padding(
          padding: EdgeInsets.all(9),
          child: Text(
            'Date',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(9),
          child: Text(model.date ?? ''),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ElevatedButton(
            child: const Text('Edit Task'),
            onPressed: () async {
              var result = await context.push('/add', extra: model);
              // ignore: use_build_context_synchronously
              if (result != null) Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete Task'),
            onPressed: () async {
              var result = await showDialog<bool?>(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: const Text('Confirmation!'),
                    content: const Text('Would you like to delete this?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () {
                          AppService().delete(model.id);
                          Navigator.pop(context, true);
                        },
                      ),
                    ],
                  );
                },
              );
              // ignore: use_build_context_synchronously
              if (result != null) Navigator.pop(context);
            },
          ),
        ]),
      ]),
    );
  }
}
