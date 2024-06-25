import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showLoadingDialog(
  BuildContext context,
  RxBool isLoading, {
  String? text,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Obx(
        () {
          if (isLoading.value) {
            return WillPopScope(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 40.w,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
              onWillPop: () async => false,
            );
          } else {
            Get.back();
            return Container();
          }
        },
      );
    },
  );
}

Future closeLoading(RxBool condition) async {
  condition.value = false;
  await Future.delayed(Duration(milliseconds: 5), () {
    condition.value = true;
  });
}
