import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/presentation/partials/laporan/calendar_filter.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/popover.dart';
import 'package:eport/app/repository/rekap_repository.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

typedef ActivityCallback = void Function(ActivityModel data);
typedef HandleDateCallback = void Function(List<DateTime?> data);

class LaporanFilter extends StatefulWidget {
  final VoidCallback onReset;
  final ActivityCallback onActivity;
  final List<ActivityModel> activities;
  final ActivityModel? value;
  final List data;
  final List<DateTime?> filterDate;
  final HandleDateCallback onDate;
  final String titleDate;

  const LaporanFilter({
    super.key,
    required this.onReset,
    required this.onActivity,
    required this.activities,
    required this.data,
    required this.onDate,
    this.value,
    this.filterDate = const [null, null],
    this.titleDate = "Tanggal Kegiatan",
  });

  @override
  State<LaporanFilter> createState() => _LaporanFilterState();
}

class _LaporanFilterState extends State<LaporanFilter> {
  bool visible = false;
  bool calendarVisible = false;
  GlobalKey buttonRef = GlobalKey();
  Offset offsetButton = Offset(0, 0);

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOffset();
      initDate();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void initDate() {
    setState(() {
      startDate = widget.filterDate[0];
      endDate = widget.filterDate[1];
      String formattedStartDate = startDate != null
          ? DateFormat('dd MMMM yyyy').format(startDate!)
          : "";
      startDateInput.text = formattedStartDate;
      String formattedEndDate =
          endDate != null ? DateFormat('dd MMMM yyyy').format(endDate!) : "";
      endDateInput.text = formattedEndDate;
    });
  }

  @override
  void didUpdateWidget(covariant LaporanFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    initDate();
  }

  void getOffset() {
    RenderBox box = buttonRef.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      Offset offsetTemp = box.localToGlobal(Offset.zero);
      offsetButton = offsetTemp;
    });
  }

  bool showCalendar = false;
  ScrollController scrollController = ScrollController();

  void toggleCalendar(bool condition) {
    setState(() {
      showCalendar = condition;
    });
    if (showCalendar) {
      scrollController.animateTo(
        200,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();

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
                constraints: BoxConstraints(
                  maxHeight: showCalendar ? 600.h : 420.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.h),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Jenis Laporan",
                              style: body3BTextStyle(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                visible = false;
                              });
                              widget.onReset();
                            },
                            child: Text(
                              'Reset',
                              style: body4BTextStyle(
                                color: ColorConstants.primary[50],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
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
                                          size: 13.sp,
                                          color: data.id == widget.value?.id
                                              ? ColorConstants.primary[70]
                                              : ColorConstants.slate[900],
                                          weight: data.id == widget.value?.id
                                              ? FontWeight.bold
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
                        "Tanggal Kegiatan",
                        style: body3BTextStyle(),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: AppInput(
                              controller: startDateInput,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 14.w,
                              ),
                              label: "Tanggal Mulai",
                              labelStyle: body4TextStyle(
                                weight: FontWeight.w500,
                              ),
                              onTap: () {
                                toggleCalendar(true);
                              },
                              readOnly: true,
                              placeholder: "01-01-2024",
                              prefixIcon: Icon(Icons.calendar_month),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: AppInput(
                              controller: endDateInput,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 14.w,
                              ),
                              label: "Tanggal Selesai",
                              labelStyle: body4TextStyle(
                                weight: FontWeight.w500,
                              ),
                              onTap: () {
                                toggleCalendar(true);
                              },
                              readOnly: true,
                              placeholder: "31-12-2024",
                              prefixIcon: Icon(Icons.calendar_month),
                            ),
                          ),
                        ],
                      ),
                      showCalendar
                          ? CalendarFilter(
                              endDate: endDate,
                              startDate: startDate,
                              onSave: (e) {
                                setState(() {
                                  startDate = e[0];
                                  String formattedStartDate = startDate != null
                                      ? DateFormat('dd MMMM yyyy')
                                          .format(startDate!)
                                      : "";
                                  startDateInput.text = formattedStartDate;
                                  endDate = e[1];
                                  String formattedEndDate = endDate != null
                                      ? DateFormat('dd MMMM yyyy')
                                          .format(endDate!)
                                      : "";
                                  endDateInput.text = formattedEndDate;
                                  visible = false;
                                });
                                widget.onDate([startDate, endDate]);
                              },
                              onToggle: (e) {
                                toggleCalendar(e);
                              },
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              visible: visible,
              onClose: () {
                setState(() {
                  visible = false;
                  calendarVisible = false;
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
            Global.isExt()
                ? Container()
                : Row(
                    children: [
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
                      GestureDetector(
                        onTap: () async {
                          RekapRepository.get()
                              .then((value) {})
                              .catchError((_) {});
                          // String url = "${dotenv.env['BASE_URL']}/api/rekap";
                          // downloadFile(url);
                        },
                        child: Image.asset(
                          "assets/icons/excel.png",
                          width: 28.w,
                          height: 28.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
