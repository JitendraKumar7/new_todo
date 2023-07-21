part of 'app_service.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class GetEvent extends AppEvent {
  const GetEvent();

  @override
  List<Object> get props => [];
}

class RefreshEvent extends AppEvent {
  final List<QueryDocumentSnapshot<TodoModel>> docs;
  final int size;

  const RefreshEvent(this.docs, this.size);

  @override
  List<Object> get props => [docs, size];
}
