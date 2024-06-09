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
            RencanaData(label: "Reklame", path: AppRoute.rencanaPatroliReklame),
            RencanaData(label: "Kransos", path: AppRoute.rencanaPatroliKransos),
            RencanaData(
              label: "Pengamanan",
              path: AppRoute.rencanaPatroliPengamanan,
            ),
            RencanaData(
              label: "Pamwal",
              path: AppRoute.rencanaPatroliPamwal,
            ),
            RencanaData(
              label: "Perizinan",
              path: AppRoute.rencanaPatroliPerizinan,
            ),
            RencanaData(label: "Piket", path: AppRoute.rencanaPatroliPiket),
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
