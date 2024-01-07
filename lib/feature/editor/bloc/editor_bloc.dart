import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'editor_event.dart';
part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(const EditorDataState()) {
    on<_OpenFile>(_onOpenFile);
    on<_CloseFile>(_onCloseFile);
  }

  FutureOr<void> _onOpenFile(_OpenFile event, Emitter<EditorState> emit) {
    final file = event.file;
    
    emit(
      EditorDataState(file: file),
    );
  }

  void _onCloseFile(_CloseFile event, Emitter<EditorState> emit) {
    emit(
      const EditorDataState(),
    );
  }
}
