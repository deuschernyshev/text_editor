import 'package:flutter/material.dart';
import 'package:text_editor/feature/app_layout/widgets/split_screen.dart';
import 'package:text_editor/feature/editor/editor.dart';
import 'package:text_editor/feature/explorer/explorer.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplitScreen(
        dividerPosition: 0.2,
        splitterAxis: Axis.vertical,
        children: <Widget>[
          Explorer(),
          Editor(),
        ],
      ),
    );
  }
}
