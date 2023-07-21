import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/todo_model.dart';

part 'app_bloc.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppService {
  final _todo = FirebaseFirestore.instance.collection('todo').withConverter(
    fromFirestore: (snapshot, options) {
      return TodoModel.fromJson(snapshot.data());
    },
    toFirestore: (model, options) {
      return model.toJson;
    },
  );

  static final AppService _instance = AppService._();

  factory AppService() => _instance;

  AppService._();

  void delete(String? id) => _todo.doc(id).delete();

  Future<QuerySnapshot<TodoModel>> get() => _todo.get();

  void add(TodoModel model) => _todo.doc('${model.id}').set(model);

  Stream<QuerySnapshot<TodoModel>> get snapshots => _todo.snapshots();
}
