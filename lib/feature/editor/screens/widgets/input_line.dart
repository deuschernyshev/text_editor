import 'package:flutter/material.dart';

class InputLine extends StatelessWidget {
  final TextEditingController textController;
  final ScrollController textFieldScrollController;

  const InputLine({
    super.key,
    required this.textController,
    required this.textFieldScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      scrollController: textFieldScrollController,
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
    );
  }
}
