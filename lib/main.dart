import 'package:app/model/todo_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'ui/index_page.dart';
import 'ui/task_add_page.dart';
import 'ui/task_detail_page.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IndexPage(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) {
        var model = state.extra == null ? null : state.extra as TodoModel;
        return TaskAddPage(model);
      },
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        var model = state.extra as TodoModel;
        return TaskDetailPage(model);
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: 'AIzaSyBA67A7HKMBj8TVqE_d3HGiYjZyQD7MbVI',
            authDomain: 'todo-task-ap.firebaseapp.com',
            projectId: 'todo-task-ap',
            storageBucket: 'todo-task-ap.appspot.com',
            messagingSenderId: '366320388218',
            appId: '1:366320388218:web:69f846d881c8c8d03853c3',
            measurementId: 'G-BT01PTLCQ0',
          )
        : null,
  );

  /// for web
  setPathUrlStrategy();

  /// user interface
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'TODO',
    );
  }
}
