part of 'editor_bloc.dart';

@immutable
sealed class EditorEvent {
  const factory EditorEvent.openFile({required FileSystemEntity file}) = _OpenFile;
  const factory EditorEvent.closeFile() = _CloseFile;
}

class _OpenFile implements EditorEvent {
  final FileSystemEntity file;

  const _OpenFile({required this.file});
}

class _CloseFile implements EditorEvent {
  const _CloseFile();
}
