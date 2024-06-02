import 'package:eport/app/controller/pamwal_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_detail_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PamwalPage extends GetView<PamwalController> {
  const PamwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanDetailScaffold(
      index: 0,
      child: Column(
        children: [],
      ),
    );
  }
}
