import 'dart:io';
import 'package:flutter/material.dart';
import 'package:text_editor/core/extensions/file_extensions.dart';

class FileTab extends StatelessWidget {
  final FileSystemEntity file;
  final VoidCallback? onClose;

  const FileTab({
    super.key,
    required this.file,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(file.name),
            const SizedBox(width: 8.0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onClose,
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
