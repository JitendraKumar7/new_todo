import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../bloc/app_service.dart';
import '../model/todo_model.dart';

class TaskAddPage extends StatefulWidget {
  final TodoModel? model;

  const TaskAddPage(this.model, {super.key});

  @override
  State<TaskAddPage> createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  final controllerDescription = TextEditingController();
  final controllerTitle = TextEditingController();
  final controllerDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerDescription.text = widget.model?.description ?? '';
    controllerTitle.text = widget.model?.title ?? '';
    controllerDate.text = widget.model?.date ?? '';
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.model?.id == null ? 'Add Task' : 'Edit Task'),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            TextFormField(
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter title';
                }
                return null;
              },
              controller: controllerTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                helperText: '',
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter description';
                }
                return null;
              },
              controller: controllerDescription,
              decoration: const InputDecoration(
                labelText: 'Description',
                helperText: '',
              ),
              minLines: 3,
              maxLines: 8,
            ),
            TextFormField(
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please choose date';
                }
                return null;
              },
              controller: controllerDate,
              decoration: const InputDecoration(
                labelText: 'Date',
                helperText: '',
              ),
              onTap: () async {
                DateTime initialDate;
                try {
                  var inputString = controllerDate.text;
                  initialDate = DateFormat('dd-MM-yyyy').parse(inputString);
                } catch (err) {
                  initialDate = DateTime.now();
                }
                var pickedDate = await showDatePicker(
                  initialDate: initialDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2050),
                  context: context,
                );
                if (pickedDate != null) {
                  var formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  debugPrint('formattedDate $formattedDate');
                  controllerDate.text = formattedDate;
                }
              },
              readOnly: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                var id =
                    widget.model?.id ?? DateTime.now().millisecondsSinceEpoch;
                var model = TodoModel(
                  description: controllerDescription.text,
                  title: controllerTitle.text,
                  date: controllerDate.text,
                  id: '$id',
                );
                AppService().add(model);
                debugPrint(model.toString());
                Navigator.pop(context, true);
              },
              child:
                  Text(widget.model?.id == null ? 'Add Task' : 'Update Task'),
            )
          ]),
        ),
      ),
    );
  }
}
