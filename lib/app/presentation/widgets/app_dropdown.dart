import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';

class AppDropdownItem<T> {
  final String text;
  final T value;
  final Widget? child;
  final bool enabled;

  AppDropdownItem({
    required this.text,
    required this.value,
    this.child,
    this.enabled = true,
  });
}

class AppDropdown<T> extends StatefulWidget {
  final List<AppDropdownItem> items;
  final T? value;
  final void Function(T?)? onChanged;
  final IconData? prefixIcon;
  final String? placeholder;
  final bool isDisabled;
  final String p;
  final String? Function(T? e)? validator;
  final String? label;

  const AppDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.prefixIcon,
    this.placeholder,
    this.isDisabled = false,
    this.validator,
    this.p = "",
    this.label,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  T? value;
  final _key = GlobalKey();
  final FocusNode _focus = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      value = widget.value;
    });

    _focus.addListener(() {
      setState(() {
        isFocused = _focus.hasFocus ? true : false;
      });
    });
  }

  @override
  void didUpdateWidget(covariant AppDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        value = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: (T? _) {
        if (widget.validator != null) {
          var validate = widget.validator!(value);

          return validate;
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.label == null
                ? Container()
                : Text(
                    widget.label!,
                    style: body3BTextStyle(color: ColorConstants.slate[700]),
                  ),
            widget.label == null ? Container() : SizedBox(height: 8.h),
            DropdownButton2<T>(
              focusNode: _focus,
              underline: Container(),
              key: _key,
              barrierColor: Color.fromRGBO(0, 0, 0, 0.3),
              isExpanded: true,
              isDense: true,
              iconStyleData: IconStyleData(
                iconSize: 1,
              ),
              value: widget.value,
              customButton: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeIn,
                width: 1.sw,
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  border: Border.all(
                    style: isFocused ? BorderStyle.solid : BorderStyle.none,
                    color: state.errorText != null
                        ? ColorConstants.error
                        : ColorConstants.primary[30]!,
                  ),
                ),
                decoration: _renderBoxDecoration(state),
                child: Row(
                  children: [
                    _renderTextDropdown(state),
                    SizedBox(width: 10),
                    Container(
                      constraints: BoxConstraints.tight(Size(40.w, 36.h)),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            height: 20.h,
                            width: 1.w,
                            color: isFocused
                                ? ColorConstants.primary[70]
                                : ColorConstants.slate[500],
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: isFocused
                                ? ColorConstants.primary[70]
                                : ColorConstants.slate[500],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onChanged: !widget.isDisabled
                  ? (T? e) {
                      print(e);
                      setState(() {
                        if (e != null) {
                          value = e;
                        }
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(e);
                      }
                    }
                  : null,
              dropdownStyleData: DropdownStyleData(
                offset: Offset(0, -10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 48.h,
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => ColorConstants.primary[60]!.withOpacity(.2),
                ),
              ),
              items: widget.items.isNotEmpty
                  ? widget.items
                      .map(
                        (e) => DropdownMenuItem<T>(
                          value: e.value,
                          onTap: null,
                          enabled: e.enabled,
                          child: e.child ??
                              Text(
                                e.text,
                                style: body3TextStyle(
                                  color: ColorConstants.slate[800],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      )
                      .toList()
                  : [
                      DropdownMenuItem<T>(
                        enabled: false,
                        child: Row(
                          children: [
                            Text(
                              "Tidak ada data",
                              style: body3TextStyle(
                                color: ColorConstants.slate[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
            ),
            SizedBox(
              height: state.errorText != null ? 4.h : 0,
            ),
            state.errorText != null
                ? Text(
                    state.errorText ?? "",
                    style: body5BTextStyle(
                      color: Colors.red[400],
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }

  Widget _renderTextDropdown(FormFieldState<T> state) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 16.w,
        ),
        child: Builder(
          builder: (context) {
            var isValid = true;
            if (value == null) {
              isValid = false;
            }
            if (value == -1) {
              isValid = false;
            }
            if (value == "") {
              isValid = false;
            }
            if (widget.items.indexWhere((element) => element.value == value) ==
                -1) {
              isValid = false;
            }

            return Text(
              widget.value == null
                  ? (widget.placeholder ?? "")
                  : isValid
                      ? widget.items
                          .firstWhere((element) => element.value == value)
                          .text
                      : widget.placeholder ?? "",
              style: body3TextStyle(
                color: (state.errorText?.isNotEmpty ?? false)
                    ? ColorConstants.error
                    : widget.value == null
                        ? ColorConstants.slate[400]
                        : ColorConstants.slate[900],
                weight:
                    widget.value == null ? FontWeight.normal : FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
    );
  }

  Decoration _renderBoxDecoration(FormFieldState<T> state) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8.w),
      color: Colors.white,
      border: Border.all(
        color: state.errorText != null
            ? ColorConstants.error
            : (isFocused
                ? ColorConstants.primary[60]!
                : ColorConstants.slate[300]!),
      ),
      boxShadow: state.errorText != null
          ? (isFocused
              ? [
                  BoxShadow(
                    color: ColorConstants.primary[70]!.withOpacity(.4),
                    offset: Offset(0, 0),
                    blurRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: ColorConstants.error.withOpacity(0.4),
                    offset: Offset(0, 0),
                    blurRadius: 4,
                  ),
                ])
          : (isFocused
              ? [
                  BoxShadow(
                    color: ColorConstants.primary[50]!.withOpacity(.6),
                    offset: Offset(0.w, 2.h),
                    blurRadius: 4.w,
                  ),
                ]
              : [ColorConstants.shadow[2]!]),
    );
  }
}
