import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/presentation/widgets/popover.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

typedef ToggleCallback = void Function(bool show);
typedef OnSearch = void Function(String value);
typedef OnSave<T> = void Function(T value);

typedef Validator = String? Function(String?)?;

class AppSearchSelect<T> extends StatefulWidget {
  final bool show;
  final ToggleCallback onTogle;
  final TextEditingController controller;
  final String? label;
  final String? placeholder;
  final List<RadioProps<T>> options;
  final OnSave<T> onSave;
  final T? value;
  final Validator? validator;

  const AppSearchSelect({
    super.key,
    required this.show,
    required this.onTogle,
    required this.controller,
    required this.options,
    this.label,
    this.placeholder,
    this.value,
    this.validator,
    required this.onSave,
  });

  @override
  State<AppSearchSelect<T>> createState() => _AppSearchSelectState<T>();
}

class _AppSearchSelectState<T> extends State<AppSearchSelect<T>> {
  GlobalKey ref = GlobalKey();
  Offset offset = Offset.zero;
  Size size = Size(0, 0);
  late T? currentValue;
  late List<RadioProps<T>> options;
  late List<RadioProps<T>> filteredOptions;
  TextEditingController inputController = TextEditingController();

  void handleChangeValue(T val) {
    setState(() {
      currentValue = val;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      currentValue = widget.value;
      options = widget.options;
      filteredOptions = options;
    });
  }

  @override
  void didUpdateWidget(covariant AppSearchSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      currentValue = widget.value;
    });
  }

  void getOffset(GlobalKey ref) {
    RenderBox box = ref.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      offset = box.localToGlobal(Offset.zero);
      size = box.size;
    });
  }

  void onFilter(String val) {
    String truncedVal = val.toLowerCase().removeAllWhitespace;
    List<RadioProps<T>> tempData = options.where((data) {
      String truncedStr = data.label.toLowerCase().removeAllWhitespace;
      if (truncedStr.contains(truncedVal)) {
        return true;
      }
      return false;
    }).toList();
    setState(() {
      filteredOptions = tempData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Popover(
      overlay: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppInput(
              controller: inputController,
              placeholder: "Cari ${widget.label}",
              prefixIcon: Icon(Icons.search),
              onChange: onFilter,
            ),
            SizedBox(height: 8.h),
            Obx(
              () => widget.label != null && widget.options.isNotEmpty
                  ? Text(
                      widget.label!,
                      style: body4BTextStyle(
                        weight: FontWeight.w600,
                      ),
                    )
                  : Container(),
            ),
            SizedBox(height: 4.h),
            Container(
              constraints: BoxConstraints(
                maxHeight: 260.h,
                minHeight: 120.h,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: options.isEmpty
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/search-not-found.svg",
                            width: 220.w,
                          ),
                          Text(
                            "Pencarian Tidak Ditemukan",
                            style: body3BTextStyle(),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Silakan coba kata kunci lainnya untuk mendapatkan hasil.",
                            style: body4TextStyle(),
                          )
                        ],
                      )
                    : AppRadioGroup<T>(
                        value: currentValue,
                        onChange: handleChangeValue as OnChange,
                        data: filteredOptions,
                      ),
              ),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => widget.options.isNotEmpty
                  ? Align(
                      alignment: Alignment.topRight,
                      child: AppButton(
                        onPressed: currentValue != null
                            ? () {
                                widget.onSave(currentValue as T);
                              }
                            : null,
                        text: "Simpan",
                        width: 170.w,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        textStyle: body3BTextStyle(
                          color: Colors.white,
                          weight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
      visible: widget.show,
      onClose: () {
        widget.onTogle(false);
      },
      left: 20.w,
      right: 20.w,
      top: offset.dy + size.height + 6.h,
      child: AppInput(
        controller: widget.controller,
        gap: 8.h,
        key: ref,
        label: widget.label,
        readOnly: true,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down,
          size: 28.w,
        ),
        onTap: () {
          getOffset(ref);
          widget.onTogle(true);
        },
        placeholder: widget.placeholder ?? "",
        validator: widget.validator,
      ),
    );
  }
}
