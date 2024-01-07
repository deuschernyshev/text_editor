part of 'explorer_bloc.dart';

@immutable
sealed class ExplorerState {
  final Directory? directory;
  final List<FileSystemEntity> filesInDirectory;

  const ExplorerState({
    this.directory,
    this.filesInDirectory = const [],
  });

  bool get hasDir => directory != null;
  int get filesCount => filesInDirectory.length;
}

final class ExplorerDataState extends ExplorerState {
  const ExplorerDataState({
    super.directory,
    super.filesInDirectory,
  });
}
