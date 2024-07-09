import 'package:eport/app/controller/cache_controller.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppLocation extends StatefulWidget {
  final String address;
  const AppLocation({
    super.key,
    this.address = "",
  });

  @override
  State<AppLocation> createState() => _AppLocationState();
}

class _AppLocationState extends State<AppLocation> {
  String address = "";
  bool isFetch = false;

  void _setAddressFromCache() {
    setState(() {
      address = CacheController.i.address.value;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (Get.currentRoute.contains("rencana")) {
        isFetch = true;
      }
      address = widget.address;
    });
    if (isFetch) {
      if (CacheController.i.address.value == "") {
        CacheController.i.getCurrentPosition().then((_) {
          _setAddressFromCache();
        });
      } else {
        _setAddressFromCache();
      }
      CacheController.i.getCurrentPosition();
    }
  }

  @override
  void didUpdateWidget(covariant AppLocation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!isFetch) {
      setState(() {
        address = widget.address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: Colors.white,
        border: Border.all(color: ColorConstants.slate[300]!),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.location_on_rounded,
              color: ColorConstants.primary[50],
              size: 18.w,
            ),
            SizedBox(width: 8.w),
            Text(
              "Lokasi ${isFetch ? "Anda" : ""}",
              style: body3BTextStyle(
                color: ColorConstants.primary[50],
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: address != ""
                  ? Text(
                      address,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: body3TextStyle(
                        color: ColorConstants.slate[600],
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox.square(
                        dimension: 24.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5.w,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
