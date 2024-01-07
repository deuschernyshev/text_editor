part of 'editor_bloc.dart';

@immutable
sealed class EditorEvent {
  const factory EditorEvent.openFile({required FileSystemEntity file}) = _OpenFile;
  const factory EditorEvent.closeFile() = _CloseFile;
  const factory EditorEvent.saveFile({required String content}) = _SaveFile;
}

class _OpenFile implements EditorEvent {
  final FileSystemEntity file;

  const _OpenFile({required this.file});
}

class _CloseFile implements EditorEvent {
  const _CloseFile();
}

class _SaveFile implements EditorEvent {
  final String content;

  const _SaveFile({required this.content});
}
