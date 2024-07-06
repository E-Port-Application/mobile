import 'package:eport/app/controller/cache_controller.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLocation extends StatefulWidget {
  const AppLocation({super.key});

  @override
  State<AppLocation> createState() => _AppLocationState();
}

class _AppLocationState extends State<AppLocation> {
  String address = "";

  @override
  void initState() {
    super.initState();
    if (CacheController.i.address.value == "") {
      CacheController.i.getCurrentPosition().then((_) {
        setState(() {
          address = CacheController.i.address.value;
        });
      });
    } else {
      setState(() {
        address = CacheController.i.address.value;
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
              color: ColorConstants.primary[70],
              size: 18.w,
            ),
            SizedBox(width: 8.w),
            Text(
              "Lokasi Anda",
              style: body3BTextStyle(
                color: ColorConstants.primary[70],
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
