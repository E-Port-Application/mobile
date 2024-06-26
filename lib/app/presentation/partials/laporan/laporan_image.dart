import 'dart:io';

import 'package:eport/app/types/laporan_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LaporanImage extends StatelessWidget {
  final File? image;
  final String? imageUrl;
  final LaporanType type;
  final VoidCallback removePhoto;
  const LaporanImage({
    super.key,
    required this.image,
    required this.imageUrl,
    required this.type,
    required this.removePhoto,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
        ),
        clipBehavior: Clip.antiAlias,
        constraints: BoxConstraints(maxHeight: 240.h),
        child: Stack(
          children: [
            Image.network(
              imageUrl!,
              width: 1.sw,
              fit: BoxFit.cover,
            ),
            type != LaporanType.history
                ? Positioned(
                    top: 10.h,
                    right: 12.w,
                    child: GestureDetector(
                      onTap: removePhoto,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.3),
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      );
    }
    if (image != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
        ),
        clipBehavior: Clip.antiAlias,
        constraints: BoxConstraints(maxHeight: 240.h),
        child: Stack(
          children: [
            Image.file(
              image!,
              width: 1.sw,
              fit: BoxFit.cover,
            ),
            type != LaporanType.history
                ? Positioned(
                    top: 10.h,
                    right: 12.w,
                    child: GestureDetector(
                      onTap: removePhoto,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.3),
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      );
    }
    return Container();
  }
}
