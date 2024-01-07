import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'explorer_event.dart';
part 'explorer_state.dart';

class ExplorerBloc extends Bloc<ExplorerEvent, ExplorerState> {
  ExplorerBloc() : super(ExplorerInitial()) {
    on<ExplorerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
