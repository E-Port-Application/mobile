import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/popover.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LaporanFilter extends StatefulWidget {
  const LaporanFilter({super.key});

  @override
  State<LaporanFilter> createState() => _LaporanFilterState();
}

class _LaporanFilterState extends State<LaporanFilter> {
  bool visible = false;
  GlobalKey buttonRef = GlobalKey();
  Offset offsetButton = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOffset();
    });
  }

  void getOffset() {
    RenderBox box = buttonRef.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      Offset offsetTemp = box.localToGlobal(Offset.zero);
      offsetButton = offsetTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppInput(
            controller: TextEditingController(),
            placeholder: "Cari Laporan Disini",
            suffixIcon: Icon(Icons.search),
          ),
        ),
        SizedBox(width: 8.w),
        Popover(
          overlay: Container(
            padding: EdgeInsets.all(16.w),
            constraints: BoxConstraints(maxHeight: 420.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.h),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Jenis Kegiatan",
                    style: body4BTextStyle(),
                  ),
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: LaporanController.i.activities
                            .map(
                              (data) => GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: ColorConstants.slate[200]!,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    data.label,
                                    style: body4TextStyle(
                                      color: ColorConstants.primary[70],
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )),
                  SizedBox(height: 16.h),
                  Text(
                    "Jenis Kegiatan",
                    style: body4BTextStyle(),
                  ),
                  ...[
                    "Hari ini",
                    "7 Hari Terakhir",
                    "Pilih Bulan",
                    "Pilih Tanggal"
                  ]
                      .map(
                        (data) => GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorConstants.slate[200]!,
                                ),
                              ),
                            ),
                            child: Text(
                              data,
                              style: body4TextStyle(),
                            ),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ),
          visible: visible,
          onClose: () {
            setState(() {
              visible = false;
            });
          },
          top: offsetButton.dy + 52.h,
          right: 20.w,
          left: 20.w,
          child: SizedBox(
            width: 40.w,
            child: ElevatedButton(
              key: buttonRef,
              onPressed: () {
                setState(() {
                  visible = true;
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(20.w, 44.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.w),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
              child: Center(
                child: Icon(Icons.filter_alt_outlined),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
