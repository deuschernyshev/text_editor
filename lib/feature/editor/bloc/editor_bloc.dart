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
    on<_SaveFile>(_onSaveFile);
  }

  void _onOpenFile(_OpenFile event, Emitter<EditorState> emit) {
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

  Future<void> _onSaveFile(_SaveFile event, Emitter<EditorState> emit) async {
    final content = event.content;

    final fileEntity = state.file;
    final file = File(fileEntity!.path);

    file.writeAsString(content).ignore();
  }
}
