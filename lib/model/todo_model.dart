import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String? description;
  final String? title;
  final String? date;
  final String? id;

  const TodoModel({
    this.description,
    this.title,
    this.date,
    this.id,
  });

  factory TodoModel.fromJson(Map<String, dynamic>? json) {
    return TodoModel(
      description: json?['description'],
      title: json?['title'],
      date: json?['date'],
      id: json?['id'],
    );
  }

  Map<String, dynamic> get toJson => {
        'description': description,
        'title': title,
        'date': date,
        'id': id,
      };

  @override
  String toString() {
    return 'TodoModel { description: $description, title: $title, date: $date, id: $id }';
  }

  @override
  List<Object?> get props => [description, title, date, id];
}
