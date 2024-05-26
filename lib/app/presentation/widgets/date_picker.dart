import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// A minimalistic date picker

void main() => runApp(const MyApp());

class DeclarativeDatePicker extends StatelessWidget {
  const DeclarativeDatePicker({
    Key? key,
    required this.visible,
    required this.onDismissed,
    required this.onClose,
    required this.child,
  }) : super(key: key);

  final bool visible;
  final Widget child;
  final VoidCallback onDismissed;
  final void Function(DateTime date) onClose;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: visible,
      portalFollower: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: onDismissed,
              child: Container(
                color: Colors.red.withOpacity(.2),
              ),
            ),
          ),
          Positioned(
            top: 32.h,
            right: 0.w,
            child: Container(
              color: Colors.red,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.ios_share_rounded,
                        ),
                        SizedBox(width: 8.w),
                        Text("Share"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.ios_share_rounded,
                        ),
                        SizedBox(width: 8.w),
                        Text("Share"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Example')),
          body: LayoutBuilder(
            builder: (_, __) {
              return LayoutBuilder(builder: (_, __) {
                return const DatePickerUsageExample();
              });
            },
          ),
        ),
      ),
    );
  }
}

class DatePickerUsageExample extends StatefulWidget {
  const DatePickerUsageExample({Key? key}) : super(key: key);

  @override
  _DatePickerUsageExampleState createState() => _DatePickerUsageExampleState();
}

class _DatePickerUsageExampleState extends State<DatePickerUsageExample> {
  DateTime? pickedDate;
  bool showDatePicker = false;

  @override
  Widget build(BuildContext context) {
    return DeclarativeDatePicker(
      visible: showDatePicker,
      onClose: (date) => setState(() {
        showDatePicker = false;
        pickedDate = date;
      }),
      onDismissed: () => setState(() => showDatePicker = false),
      child: ElevatedButton(
        onPressed: () => setState(() => showDatePicker = true),
        child: const Text('pick a date'),
      ),
    );
  }
}
