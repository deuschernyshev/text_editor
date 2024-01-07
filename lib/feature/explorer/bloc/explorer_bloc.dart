import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'explorer_event.dart';
part 'explorer_state.dart';

class ExplorerBloc extends Bloc<ExplorerEvent, ExplorerState> {
  ExplorerBloc() : super(const ExplorerDataState()) {
    on<_OpenDirectory>(_onOpenDirectory);
    on<_RefreshCurrentDirectory>(_onRefreshCurrentDirectory);
  }

  Future<void> _onOpenDirectory(_OpenDirectory event, Emitter<ExplorerState> emit) async {
    final directory = await _getDirectory();
    final filesInDirectory = await _getFilesInSelectedDirectory(directory);

    emit(
      ExplorerDataState(
        directory: directory,
        filesInDirectory: filesInDirectory,
      ),
    );
  }

  Future<void> _onRefreshCurrentDirectory(_RefreshCurrentDirectory event, Emitter<ExplorerState> emit) async {
    final filesInDirectory = await _getFilesInSelectedDirectory(state.directory);

    emit(
      ExplorerDataState(
        directory: state.directory,
        filesInDirectory: filesInDirectory,
      ),
    );
  }

  Future<Directory?> _getDirectory() async {
    final directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath == null) return null;

    final dir = Directory(directoryPath);
    
    return dir;
  }

  Future<List<FileSystemEntity>> _getFilesInSelectedDirectory(Directory? dir) async {
    if (dir == null) return [];

    final entities = await dir.list().toList();

    return entities;
  }
}
