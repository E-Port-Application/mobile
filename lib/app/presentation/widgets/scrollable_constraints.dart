import 'package:flutter/material.dart';

class ScrollableConstraints extends StatelessWidget {
  final Widget child;
  ScrollPhysics? physics;
  ScrollableConstraints({super.key, required this.child, this.physics});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: physics,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }
}
