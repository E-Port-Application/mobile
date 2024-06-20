import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadPhoto extends StatelessWidget {
  final VoidCallback uploadCamera;
  final VoidCallback uploadGallery;
  const UploadPhoto({
    super.key,
    required this.uploadCamera,
    required this.uploadGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Text(
          "Pilih salah satu opsi",
          style: body6TextStyle(color: ColorConstants.slate[500]),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: uploadCamera,
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 28.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Kamera",
                  style: body5BTextStyle(),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Column(
              children: [
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: uploadGallery,
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.photo_library_outlined,
                        size: 28.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Galeri",
                  style: body5BTextStyle(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
