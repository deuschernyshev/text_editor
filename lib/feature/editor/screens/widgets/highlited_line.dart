import 'package:flutter/material.dart';

class HighlitedLine extends StatelessWidget {
  final ScrollController lineNumbersScrollController;
  final int linesCount;
  final int currentLineNumber;

  const HighlitedLine({
    super.key,
    required this.currentLineNumber,
    required this.lineNumbersScrollController,
    required this.linesCount,
  });


  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.separated(
        controller: lineNumbersScrollController,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: linesCount,
        itemBuilder: (context, index) => Container(
          color: _getLineSelectionColor(currentLineNumber, index),
          width: MediaQuery.of(context).size.width,
          height: 20,
        ),
        separatorBuilder: (context, index) {
          return const SizedBox(height: 1);
        },
      ),
    );
  }

  Color? _getLineSelectionColor(int currentLineNumber, int index) {
    return currentLineNumber == index + 1 ? Colors.grey[300] : Colors.transparent;
  }
}
