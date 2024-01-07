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
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 10,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              file.name,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(width: 10.0),
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
