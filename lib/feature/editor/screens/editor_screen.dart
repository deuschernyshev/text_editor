import 'package:flutter/material.dart';
import 'package:text_editor/feature/editor/screens/widgets/colored_line.dart';
import 'package:text_editor/feature/editor/screens/widgets/input_line.dart';
import 'package:text_editor/feature/editor/screens/widgets/row_number.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final _textController = TextEditingController();
  final _textFieldScrollController = ScrollController();
  final _lineNumbersScrollController = ScrollController();

  int _linesCount = 1;

  @override
  void initState() {
    super.initState();

    _lineCountListener();
    _scrollListener();
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
    final String text =
        _textController.text.substring(0, cursorPosition.clamp(0, _textController.text.length));
    final List<String> lines = text.split('\n');

    return lines.length;
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
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: 50,
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: RowNumber(
              lineNumbersScrollController: _lineNumbersScrollController,
              linesCount: _linesCount,
              currentLineNumber: _getCurrentLineNumber(),
            ),
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: <Widget>[
                ColoredLine(
                  lineNumbersScrollController: _lineNumbersScrollController,
                  linesCount: _linesCount,
                  currentLineNumber: _getCurrentLineNumber(),
                ),
                InputLine(
                  textController: _textController,
                  textFieldScrollController: _textFieldScrollController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
