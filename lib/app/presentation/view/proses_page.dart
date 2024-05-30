import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eport/app/controller/proses_controller.dart';

class ProsesPage extends GetView<ProsesController> {
  const ProsesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold(
      index: 1,
      child: Column(
        children: [],
      ),
    );
  }
}
