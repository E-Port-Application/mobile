import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RencanaData {
  final String label;
  final String path;

  const RencanaData({
    required this.label,
    required this.path,
  });
}

class CardRencana extends StatefulWidget {
  final List<RencanaData>? children;
  final String label;
  final String? path;
  const CardRencana({
    super.key,
    this.children,
    required this.label,
    this.path,
  });

  @override
  State<CardRencana> createState() => _CardRencanaState();
}

class _CardRencanaState extends State<CardRencana>
    with TickerProviderStateMixin {
  bool isOpen = false;
  bool isDropdown = false;
  late Animation<double> rotationAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    if (widget.children != null) {
      setState(() {
        isDropdown = true;
      });
    }
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );

    rotationAnimation = Tween<double>(
      begin: 0,
      end: -0.75,
    ).animate(animationController);
  }

  void toggleRotation() {
    if (isOpen) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.path != null) {
              Get.toNamed(widget.path!);
              return;
            }
            toggleRotation();
          },
          child: Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.02),
                  offset: Offset(0, 2),
                  blurRadius: 4.w,
                ),
              ],
            ),
            margin: EdgeInsets.only(bottom: 16.h),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: body3BTextStyle(),
                  ),
                  RotationTransition(
                    turns: rotationAnimation,
                    child: Icon(
                      Icons.chevron_right,
                      size: 26.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        widget.children != null && isOpen
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.children!
                    .map(
                      (e) => RencanaChild(
                        data: e,
                      ),
                    )
                    .toList(),
              )
            : Container()
      ],
    );
  }
}

class RencanaChild extends StatefulWidget {
  final RencanaData data;
  const RencanaChild({
    super.key,
    required this.data,
  });

  @override
  State<RencanaChild> createState() => _RencanaChildState();
}

class _RencanaChildState extends State<RencanaChild> {
  bool isInit = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) => {
          setState(() {
            isInit = true;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isInit ? 1 : 0,
      duration: Duration(milliseconds: 400),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.02),
              offset: Offset(0, 2),
              blurRadius: 4.w,
            ),
          ],
        ),
        child: Text(
          widget.data.label,
          style: body3BTextStyle(
            weight: FontWeight.w500,
            size: 13.sp,
          ),
        ),
      ),
    );
  }
}
