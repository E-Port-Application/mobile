import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class Popover extends StatefulWidget {
  final Widget child;
  final Widget overlay;
  double? top;
  double? bottom;
  double? left;
  double? right;
  final bool visible;
  final VoidCallback onClose;

  Popover({
    super.key,
    required this.overlay,
    required this.visible,
    required this.onClose,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.child,
  });

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000)).then((value) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: widget.visible,
      portalFollower: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                widget.onClose();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.black.withOpacity(.2),
              ),
            ),
          ),
          Positioned(
            top: widget.top,
            bottom: widget.bottom,
            left: widget.left,
            right: widget.right,
            child: widget.visible
                ? AnimatedOverlay(child: widget.overlay)
                : Container(),
          ),
        ],
      ),
      child: widget.child,
    );
  }
}

class AnimatedOverlay extends StatefulWidget {
  final Widget child;
  const AnimatedOverlay({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedOverlay> createState() => _AnimatedOverlayState();
}

class _AnimatedOverlayState extends State<AnimatedOverlay> {
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      setState(() {
        isMounted = true;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isMounted ? 1 : 0,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}
