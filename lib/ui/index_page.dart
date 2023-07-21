import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/app_service.dart';
import '../model/todo_model.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
        centerTitle: false,
      ),
      body: BlocBuilder<TodoBloc, AppState>(
        bloc: TodoBloc(),
        builder: (context, state) {
          if (state is AppSuccess) {
            var list = state.docs.map((e) => e.data()).toList();
            if (list.isEmpty) {
              return const Center(
                child: Text(
                  'Add Records',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            return ListView(children: [
              const Padding(
                padding: EdgeInsets.all(9),
                child: Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              ...getToday(list).map((model) => TileWidget(model)),
              const Padding(
                padding: EdgeInsets.all(9),
                child: Text(
                  'Tomorrow',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              ...getTomorrow(list).map((model) => TileWidget(model)),
              const Padding(
                padding: EdgeInsets.all(9),
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              ...getUpcoming(list).map((model) => TileWidget(model)),
            ]);
          }
          if (state is AppError) {
            return Center(
              child: Text(
                '${state.error}',
                style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 18,
                ),
              ),
            );
          }
          return const Center(
              child: Text(
            'Loading...',
            style: TextStyle(fontSize: 18),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<TodoModel> getToday(List<TodoModel> list) {
    var formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return list.where((e) => e.date == formattedDate).toList();
  }

  List<TodoModel> getTomorrow(List<TodoModel> list) {
    var tomorrowDate = DateTime.now().copyWith(day: DateTime.now().day + 1);
    var formattedDate = DateFormat('dd-MM-yyyy').format(tomorrowDate);
    return list.where((e) => e.date == formattedDate).toList();
  }

  List<TodoModel> getUpcoming(List<TodoModel> list) {
    var tomorrowDate = DateTime.now().copyWith(day: DateTime.now().day + 1);
    return list.where((e) {
      var date = DateFormat('dd-MM-yyyy').parse('${e.date}');
      return date.isAfter(tomorrowDate);
    }).toList();
  }
}

class TileWidget extends StatelessWidget {
  final TodoModel model;

  String get url {
    var sig = Random().nextInt(999999);
    return 'https://source.unsplash.com/random/60x60?sig=$sig';
  }

  const TileWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push('/details', extra: model),
      title: Text(model.title ?? ''),
      leading: Container(
        height: 40,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.hardEdge,
        child: Image.network(url),
      ),
    );
  }
}
