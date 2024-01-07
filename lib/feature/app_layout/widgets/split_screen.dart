import 'package:flutter/material.dart';

class SplitScreen extends StatefulWidget {
  final List<Widget> children;
  final Axis splitterAxis;
  final double dividerPosition;

  const SplitScreen({
    super.key,
    required this.children,
    required this.splitterAxis,
    this.dividerPosition = 0.5,
  });

  @override
  State<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  late double _dividerPosition;

  @override
  void initState() {
    super.initState();

    assert(widget.children.length == 2, 'SplitScreen must have only 2 children.');

    _dividerPosition = widget.dividerPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: (_dividerPosition * 100).round(),
          child: widget.children[0],
        ),
        MouseRegion(
          cursor: SystemMouseCursors.resizeLeftRight,
          child: GestureDetector(
            onHorizontalDragUpdate: _onDragDivider,
            child: Container(
              width: 1,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          flex: ((1 - _dividerPosition) * 100).round(),
          child: widget.children[1],
        ),
      ],
    );
  }

  void _onDragDivider(DragUpdateDetails details) {
    setState(() {
      _dividerPosition += details.primaryDelta! / MediaQuery.of(context).size.width;
      
      if (_dividerPosition < 0.1) {
        _dividerPosition = 0.1;
      } else if (_dividerPosition > 0.9) {
        _dividerPosition = 0.9;
      }
    });
  }
}
