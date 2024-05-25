import 'package:eport/app/controller/register_controller.dart';
import 'package:eport/app/presentation/widgets/scrollable_constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RegisterPage')),
      body: ScrollableConstraints(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("asa"),
            Expanded(child: Container()),
            Text("asa"),
          ],
        ),
      ),
    );
  }
}
