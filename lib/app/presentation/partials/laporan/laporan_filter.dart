import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/popover.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef ActivityCallback = void Function(ActivityModel data);

class LaporanFilter extends StatefulWidget {
  final VoidCallback onReset;
  final ActivityCallback onActivity;
  final List<ActivityModel> activities;
  final ActivityModel? value;
  final List<LaporanModel> data;

  const LaporanFilter({
    super.key,
    required this.onReset,
    required this.onActivity,
    required this.activities,
    required this.data,
    this.value,
  });

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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppInput(
                controller: TextEditingController(),
                placeholder: "Cari laporan kegiatan disini",
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Jenis Kegiatan",
                              style: body4BTextStyle(),
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onReset,
                            child: Text(
                              'Reset',
                              style: body4BTextStyle(
                                color: ColorConstants.primary[70],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: widget.activities
                                .map(
                                  (data) => GestureDetector(
                                    onTap: () {
                                      widget.onActivity(data);
                                      setState(() {
                                        visible = false;
                                      });
                                    },
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
                                          color: data.id == widget.value?.id
                                              ? ColorConstants.primary[70]
                                              : ColorConstants.slate[900],
                                          weight: data.id == widget.value?.id
                                              ? FontWeight.w600
                                              : FontWeight.normal,
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
                    getOffset();
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
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.w),
                  boxShadow: [ColorConstants.shadow[6]!],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 7.h,
                ),
                child: Text(
                  "Total Seluruh Laporan : ${widget.data.length}",
                  style: body5BTextStyle(),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Text(
              "Unduh Laporan",
              style: body5BTextStyle(),
            ),
            Image.asset(
              "assets/icons/pdf.png",
              width: 28.w,
              height: 28.h,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/icons/excel.png",
              width: 28.w,
              height: 28.h,
              fit: BoxFit.cover,
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
