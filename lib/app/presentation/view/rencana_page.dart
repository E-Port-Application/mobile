import 'package:eport/app/controller/rencana_controller.dart';
import 'package:eport/app/presentation/partials/laporan/card_rencana.dart';
import 'package:eport/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RencanaPage extends GetView<RencanaController> {
  const RencanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        {
          "label": "Patroli",
          "children": [
            RencanaData(label: "PKL", path: AppRoute.rencanaPatroliPkl),
            RencanaData(label: "Reklame", path: ""),
            RencanaData(label: "Kransos", path: ""),
            RencanaData(label: "Pengamanan", path: ""),
            RencanaData(label: "Pamwal", path: ""),
            RencanaData(label: "Perizinan", path: ""),
            RencanaData(label: "Piket", path: ""),
          ]
        },
        {
          "label": "Operasi Kegiatan",
        }
      ]
          .map(
            (e) => CardRencana(
              label: e["label"] as String,
              path: e["path"] as String?,
              children: e['children'] as List<RencanaData>?,
            ),
          )
          .toList(),
    );
  }
}
