import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_layout_event.dart';
part 'app_layout_state.dart';

class AppLayoutBloc extends Bloc<AppLayoutEvent, AppLayoutState> {
  AppLayoutBloc() : super(AppLayoutInitial()) {
    on<AppLayoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
