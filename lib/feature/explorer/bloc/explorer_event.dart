part of 'explorer_bloc.dart';

@immutable
sealed class ExplorerEvent {
  const factory ExplorerEvent.openDirectory() = _OpenDirectory;
  const factory ExplorerEvent.refreshCurrentDirectory() = _RefreshCurrentDirectory;
}

class _OpenDirectory implements ExplorerEvent {
  const _OpenDirectory();
}

class _RefreshCurrentDirectory implements ExplorerEvent {
  const _RefreshCurrentDirectory();
}
