import 'package:flutter/material.dart';

class InputWorkspace extends StatelessWidget {
  final TextEditingController textController;
  final ScrollController scrollController;

  const InputWorkspace({
    super.key,
    required this.textController,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      scrollController: scrollController,
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
