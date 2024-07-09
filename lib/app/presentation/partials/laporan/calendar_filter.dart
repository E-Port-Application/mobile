import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

typedef SaveCallback = void Function(List<DateTime?> data);
typedef ToggleCallback = void Function(bool condition);

class CalendarFilter extends StatefulWidget {
  final SaveCallback onSave;
  final ToggleCallback onToggle;
  final DateTime? startDate;
  final DateTime? endDate;
  const CalendarFilter({
    super.key,
    required this.onSave,
    required this.onToggle,
    this.startDate,
    this.endDate,
  });

  @override
  State<CalendarFilter> createState() => _CalendarFilterState();
}

class _CalendarFilterState extends State<CalendarFilter> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startDate = widget.startDate;
        endDate = widget.endDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          availableCalendarFormats: {
            CalendarFormat.month: 'Month',
          },
          headerStyle: HeaderStyle(
            titleTextStyle: body3BTextStyle(),
            titleCentered: true,
            leftChevronMargin: EdgeInsets.zero,
            rightChevronMargin: EdgeInsets.zero,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: body4TextStyle(weight: FontWeight.w500),
            weekendStyle: body4TextStyle(
              weight: FontWeight.w500,
              color: ColorConstants.error,
            ),
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: body4TextStyle(),
            todayTextStyle: body4TextStyle(color: Colors.white),
            weekendTextStyle: body4TextStyle(color: ColorConstants.error),
            outsideTextStyle: body4TextStyle(color: ColorConstants.slate[300]),
            selectedTextStyle: body4TextStyle(color: Colors.white),
            rangeEndTextStyle: body4TextStyle(color: Colors.white),
            rangeStartTextStyle: body4TextStyle(color: Colors.white),
            withinRangeTextStyle: body4TextStyle(),
            tablePadding: EdgeInsets.zero,
            todayDecoration: BoxDecoration(
              color: ColorConstants.info[50],
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            rangeStartDecoration: BoxDecoration(
              color: ColorConstants.primary[60],
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: BoxDecoration(
              color: ColorConstants.primary[60],
              shape: BoxShape.circle,
            ),
            withinRangeDecoration: BoxDecoration(
              color: ColorConstants.primary[60]!.withOpacity(.2),
              shape: BoxShape.circle,
            ),
            rangeHighlightColor: ColorConstants.primary[50]!.withOpacity(.2),
          ),
          rangeSelectionMode: RangeSelectionMode.toggledOn,
          onRangeSelected: (start, end, focusedDay) {
            setState(() {
              if (start != null) startDate = start;
              if (end != null) endDate = end;
              _focusedDay = focusedDay;
            });
          },
          rangeStartDay: startDate,
          rangeEndDay: endDate,
          currentDay: DateTime.now(),
        ),
        Row(
          children: [
            Expanded(
              child: AppButton(
                onPressed: () {
                  setState(() {
                    startDate = null;
                    endDate = null;
                    widget.onSave([startDate, endDate]);
                    widget.onToggle(false);
                  });
                },
                text: "Reset",
                variant: AppButtonVariant.secondary,
                padding: EdgeInsets.symmetric(vertical: 20.h),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: AppButton(
                onPressed: () {
                  widget.onSave([startDate, endDate]);
                  widget.onToggle(false);
                },
                text: "Simpan",
                padding: EdgeInsets.symmetric(vertical: 20.h),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
