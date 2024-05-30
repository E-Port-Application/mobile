import 'package:eport/app/controller/perkada_page_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_detail_scaffold.dart';
import 'package:eport/app/presentation/widgets/app_dropdown.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PerkadaPage extends GetView<PerkadaController> {
  const PerkadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanDetailScaffold(
      title: "Penegakan Perda Perkada",
      index: 1,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...controller.inputList.map((element) {
              if (element.type == PType.input) {
                return AppInput(
                  controller: controller.form[element.id]!,
                  label: element.label,
                  placeholder: element.placeholder ?? "",
                  margin: 12.h,
                  hint: element.hint,
                );
              }
              if (element.type == PType.date) {
                return AppInput(
                  controller: controller.form[element.id]!,
                  readOnly: true,
                  onTap: () async {
                    try {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1000),
                        lastDate: DateTime(2999),
                      );
                      if (date != null) {
                        controller.form[element.id]!.text =
                            DateFormat('dd MMMM yyyy').format(date);
                      }
                    } catch (err) {
                      showAlert(err.toString());
                    }
                  },
                  label: element.label,
                  placeholder: element.placeholder ?? "",
                  margin: 12.h,
                );
              }
              if (element.type == PType.textarea) {
                return AppInput(
                  controller: controller.form[element.id]!,
                  label: element.label,
                  placeholder: element.placeholder ?? "",
                  maxLines: 6,
                  margin: 12.h,
                  hint: element.hint,
                );
              }
              if (element.type == PType.dropdown) {
                return AppDropdown<String>(
                  onChanged: (e) {
                    controller.form[element.id]!.value = e!;
                  },
                  value: controller.form[element.id]!.value,
                  label: element.label,
                  placeholder: element.placeholder,
                  items: [
                    AppDropdownItem(
                      text: "Pelanggaran 1",
                      value: "pelanggaran-1",
                    ),
                    AppDropdownItem(
                      text: "Pelanggaran 2",
                      value: "pelanggaran-2",
                    ),
                    AppDropdownItem(
                      text: "Pelanggaran 3",
                      value: "pelanggaran-3",
                    ),
                  ],
                );
              }
              return Text("asd");
            }).toList(),
          ],
        ),
      ),
    );
  }
}
