part of 'app_service.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppProgress extends AppState {}

class AppSuccess extends AppState {
  final List<QueryDocumentSnapshot<TodoModel>> docs;
  final int length;

  const AppSuccess(this.docs, this.length);

  @override
  List<Object> get props => [docs, length];
}

class AppError extends AppState {
  final Object error;

  const AppError(this.error);

  @override
  List<Object> get props => [error];
}
