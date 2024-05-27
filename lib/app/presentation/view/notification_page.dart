import 'package:eport/app/controller/notification_controller.dart';
import 'package:eport/app/presentation/partials/notification/card_notification.dart';
import 'package:eport/app/presentation/widgets/app_bottombar.dart';
import 'package:eport/app/presentation/widgets/app_header.dart';
import 'package:eport/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: "Notifikasi",
      ),
      bottomNavigationBar: AppBottombar(path: AppRoute.notification),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            children: [
              CardNotification(),
              CardNotification(),
              CardNotification(),
            ],
          ),
        ),
      ),
    );
  }
}
