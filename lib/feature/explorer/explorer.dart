import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor/core/extensions/file_extensions.dart';
import 'package:text_editor/feature/editor/bloc/editor_bloc.dart';
import 'package:text_editor/feature/explorer/bloc/explorer_bloc.dart';
import 'package:text_editor/feature/explorer/widgets/file_button.dart';

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  late final ExplorerBloc _explorerBloc;
  late final EditorBloc _editorBloc;

  @override
  void initState() {
    super.initState();

    _initBlocs();
  }

  void _initBlocs() {
    _explorerBloc = context.read<ExplorerBloc>();
    _editorBloc = context.read<EditorBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExplorerBloc, ExplorerState>(
        builder: (context, state) {
          if (!state.hasDir) {
            return Center(
              child: OutlinedButton(
                onPressed: _openDirectory,
                child: const Text('Open Directory'),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.folder),
                    const SizedBox(width: 8),
                    Text(
                      state.directory!.name,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Divider(),
                  ),
                  IconButton(
                    onPressed: _refreshCurrentDirectory,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: state.filesCount,
                  itemBuilder: (context, index) {
                    final file = state.filesInDirectory[index];

                    return FileButton(
                      onPressed: () => _openFile(file),
                      file: file,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openDirectory() {
    _explorerBloc.add(ExplorerEvent.openDirectory());
  }

  void _refreshCurrentDirectory() {
    _explorerBloc.add(ExplorerEvent.refreshCurrentDirectory());
  }

  void _openFile(FileSystemEntity file) {
    _editorBloc.add(EditorEvent.openFile(file: file));
  }
}
