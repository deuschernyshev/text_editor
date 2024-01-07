part of 'editor_bloc.dart';

@immutable
sealed class EditorState {
  final FileSystemEntity? file;

  const EditorState({this.file});

  bool get hasFile => file != null;
}

final class EditorDataState extends EditorState {
  const EditorDataState({super.file});
}
