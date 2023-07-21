part of 'app_service.dart';

class TodoBloc extends Bloc<AppEvent, AppState> {
  TodoBloc() : super(AppProgress()) {
    on<RefreshEvent>((event, emit) async {
      emit(AppSuccess(event.docs, event.size));
    });
    on<GetEvent>((event, emit) async {
      var data = await AppService().get();
      emit(AppSuccess(data.docs, data.size));
    });
    add(const GetEvent());
    AppService().snapshots.listen((event) {
      add(RefreshEvent(event.docs, event.size));
    });
  }
}
