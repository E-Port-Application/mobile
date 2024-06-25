import 'package:eport/styles/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final Widget overlay;
  final bool show;

  const AppShimmer({
    super.key,
    this.show = true,
    required this.overlay,
    required this.child,
  });

  factory AppShimmer.loading({required Widget overlay}) {
    return AppShimmer(
      overlay: overlay,
      show: false,
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return child;
    }
    return Shimmer.fromColors(
      baseColor: ColorConstants.slate[200]!,
      highlightColor: ColorConstants.slate[25]!,
      enabled: true,
      child: overlay,
    );
  }
}
