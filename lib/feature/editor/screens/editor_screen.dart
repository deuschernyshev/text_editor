import 'package:flutter/material.dart';

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
    final String text = _textController.text.substring(0, cursorPosition.clamp(0, _textController.text.length));
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
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.separated(
                controller: _lineNumbersScrollController,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: _linesCount,
                itemBuilder: (context, index) => Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 14,
                      color: _getLineNumberColor(index),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 1);
                },
              ),
            ),
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: <Widget>[
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: ListView.separated(
                    controller: _lineNumbersScrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _linesCount,
                    itemBuilder: (context, index) => Container(
                      color: _getLineSelectionColor(index),
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 1);
                    },
                  ),
                ),
                TextField(
                  controller: _textController,
                  scrollController: _textFieldScrollController,
                  scrollPhysics: const ClampingScrollPhysics(),
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  scrollPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color? _getLineSelectionColor(int index) {
    return _getCurrentLineNumber() == index + 1 ? Colors.grey[300] : Colors.transparent;
  }

  Color? _getLineNumberColor(int index) {
    return _getCurrentLineNumber() == index + 1 ? Colors.grey[700] : Colors.grey[400];
  }
}
