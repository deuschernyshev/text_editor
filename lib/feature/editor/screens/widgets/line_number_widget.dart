import 'package:flutter/material.dart'; 

class LineNumberWidget extends StatelessWidget {
  final ScrollController lineNumbersScrollController;
  final int linesCount;
  final int currentLineNumber;

  const LineNumberWidget({
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
          alignment: Alignment.bottomRight,
          child: Text(
            '${index + 1}',
            style: TextStyle(
              fontSize: 14,
              color: _getLineNumberColor(currentLineNumber, index),
            ),
          ),
        ),
        separatorBuilder: (context, index) {
          return const SizedBox(height: 1);
        },
      ),
    );
  }

  Color? _getLineNumberColor(int currentLineNumber ,int index) {
    return currentLineNumber == index + 1 ? Colors.grey[700] : Colors.grey[400];
  }
}
