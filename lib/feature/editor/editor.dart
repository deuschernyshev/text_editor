import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor/core/extensions/file_extensions.dart';
import 'package:text_editor/feature/editor/bloc/editor_bloc.dart';
import 'package:text_editor/feature/editor/widgets/file_tab.dart';
import 'package:text_editor/feature/editor/widgets/highlighted_line.dart';
import 'package:text_editor/feature/editor/widgets/input_workspace.dart';
import 'package:text_editor/feature/editor/widgets/line_number_widget.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  late final EditorBloc _bloc;

  final _textController = TextEditingController();
  final _textFieldScrollController = ScrollController();
  final _lineNumbersScrollController = ScrollController();

  int _linesCount = 1;

  @override
  void initState() {
    super.initState();

    _initBlocs();

    _lineCountListener();
    _scrollListener();
  }

  void _initBlocs() {
    _bloc = context.read<EditorBloc>();
  }

  void _lineCountListener() {
    _textController.addListener(() {
      setState(() {
        _linesCount = _textController.text.split('\n').length;
      });
    });
  }

  void _scrollListener() {
    _textFieldScrollController.addListener(() {
      final offset = _textFieldScrollController.offset;

      _lineNumbersScrollController.jumpTo(offset);
    });
  }

  int _getCurrentLineNumber() {
    final int cursorPosition = _textController.selection.baseOffset;
    final String text = _textController.text.substring(0, cursorPosition.clamp(0, _textController.text.length));
    final List<String> lines = text.split('\n');

    return lines.length;
  }

  void _fileContentListener(BuildContext context, EditorState state) {
    final file = state.file;

    if (file == null) return;

    _textController.value = TextEditingValue(
      text: file.readAsStringSync(),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _textFieldScrollController.dispose();
    _lineNumbersScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditorBloc, EditorState>(
      listenWhen: (previous, current) => previous.file != current.file,
      listener: _fileContentListener,
      child: BlocBuilder<EditorBloc, EditorState>(
        builder: (context, state) {
          if (!state.hasFile) return const SizedBox();

          return PlatformMenuBar(
            menus: <PlatformMenu>[
              PlatformMenu(
                label: 'File',
                menus: <PlatformMenuItem>[
                  PlatformMenuItemGroup(
                    members: <PlatformMenuItem>[
                      PlatformMenuItem(
                        label: 'Save',
                        onSelected: _saveFile,
                      ),
                    ],
                  ),
                ],
              ),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FileTab(
                  file: state.file!,
                  onClose: _closeFile,
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50,
                        padding: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        child: LineNumberWidget(
                          scrollController: _lineNumbersScrollController,
                          linesCount: _linesCount,
                          currentLineNumber: _getCurrentLineNumber(),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          children: <Widget>[
                            HighlightedLine(
                              scrollController: _lineNumbersScrollController,
                              linesCount: _linesCount,
                              currentLineNumber: _getCurrentLineNumber(),
                            ),
                            InputWorkspace(
                              textController: _textController,
                              scrollController: _textFieldScrollController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _closeFile() {
    _bloc.add(const EditorEvent.closeFile());
  }

  void _saveFile() {
    final content = _textController.text;

    _bloc.add(EditorEvent.saveFile(content: content));
  }
}
