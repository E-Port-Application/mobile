import 'package:eport/app/controller/notification_controller.dart';
import 'package:eport/app/presentation/widgets/app_bottombar.dart';
import 'package:eport/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottombar(path: AppRoute.notification),
    );
  }
}
