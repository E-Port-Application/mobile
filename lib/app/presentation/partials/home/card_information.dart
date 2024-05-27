import 'package:eport/app/controller/home_controller.dart';
import 'package:eport/app/presentation/widgets/popover.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardInformation extends StatefulWidget {
  const CardInformation({super.key});

  @override
  State<CardInformation> createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation> {
  HomeController controller = HomeController.i;
  bool visible = false;
  GlobalKey moreKey = GlobalKey();
  Offset offsetMore = Offset(0, 0);
  void onClose() {
    setState(() {
      visible = false;
    });
  }

  void openPopup() {
    setState(() {
      visible = true;
    });
  }

  void getOffset() {
    RenderBox box = moreKey.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      Offset offsetTemp = box.localToGlobal(Offset.zero);
      if (offsetTemp.dy > 1.sh) {
        offsetTemp = Offset(offsetTemp.dx, 200.h);
      }
      offsetMore = offsetTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOffset();
      controller.scrolled.listen((p0) {
        getOffset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            offset: Offset(0, 4),
            blurRadius: 8.w,
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: ColorConstants.slate[300]!,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Image.asset(
              "assets/images/news-1.png",
              width: 137.w,
              height: 140.h,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Demi Kenyamanan Pejalan Kaki, Satpol PP Kota Batu Lakukan Penertiban",
                    style: body3BTextStyle(),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.w),
                          color: ColorConstants.slate[400],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "20 Mei 2024",
                          style: body4BTextStyle(
                            color: ColorConstants.slate[400],
                            height: 1,
                          ),
                        ),
                      ),
                      Popover(
                        overlay: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                offset: Offset(0, 0),
                                spreadRadius: 1.w,
                                blurRadius: 8.w,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 12.h,
                                  ),
                                  constraints: BoxConstraints(minWidth: 160.w),
                                  child: IntrinsicWidth(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.ios_share,
                                          size: 18.w,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Share",
                                          style: body4TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1.h,
                                width: 160.w,
                                color: ColorConstants.slate[200],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 12.h,
                                  ),
                                  constraints: BoxConstraints(minWidth: 160.w),
                                  child: IntrinsicWidth(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.bookmark_outline,
                                          size: 18.w,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Bookmark",
                                          style: body4TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        visible: visible,
                        onClose: onClose,
                        top: offsetMore.dy + 32.h,
                        right: 1.sw - offsetMore.dx - 30.w,
                        child: GestureDetector(
                          key: moreKey,
                          onTap: openPopup,
                          child: Icon(
                            Icons.more_horiz,
                            size: 24.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}
