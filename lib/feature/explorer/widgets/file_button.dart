import 'dart:io';

import 'package:flutter/material.dart';
import 'package:text_editor/core/extensions/file_extensions.dart';

class FileButton extends StatefulWidget {
  final FileSystemEntity file;
  final VoidCallback? onPressed;

  const FileButton({
    super.key,
    required this.file,
    this.onPressed,
  });


  @override
  State<FileButton> createState() => _FileButtonState();
}

class _FileButtonState extends State<FileButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => _setIsHovered(true),
      onExit: (event) => _setIsHovered(false),
      child: GestureDetector(
        onTap: widget.file.isDir ? null : widget.onPressed,
        child: Column(
          children: <Widget>[
            Container(
              color: _getColor(),
              child: Row(
                children: <Widget>[
                  Icon(widget.file.isDir ? Icons.folder_outlined : Icons.file_copy_outlined),
                  const SizedBox(width: 8),
                  Text(
                    widget.file.name,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? _getColor() {
    return _isHovered ? Colors.grey[300] : Colors.transparent;
  }

  void _setIsHovered(bool value) {
    setState(() {
      _isHovered = value;
    });
  }
}
