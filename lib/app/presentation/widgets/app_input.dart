import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';

typedef ValidatorCallback = String? Function(String?)?;

class AppInput extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final ValidatorCallback validator;
  final String placeholder;
  final void Function(String)? onChange;
  final TextInputType? keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? prefix;
  final bool obscureText;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? title;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsets? padding;
  final String? hint;
  final Size? prefixConstraints;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final double? gap;
  final double? margin;

  const AppInput({
    super.key,
    this.label,
    this.suffixIcon,
    this.title,
    required this.controller,
    this.placeholder = "",
    this.onChange,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixIcon,
    this.prefix,
    this.obscureText = false,
    this.onTap,
    this.textInputAction,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.padding,
    this.hint,
    this.prefixConstraints,
    this.hintStyle,
    this.textStyle,
    this.gap,
    this.margin,
    this.labelStyle,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isFocused = false;
  bool isEmpty = true;
  bool isVisible = false;
  bool isInit = true;
  final FocusNode _focus = FocusNode();
  GlobalKey<FormFieldState> inputKey = GlobalKey();
  ValidatorCallback? validator;

  void initInput() {
    setState(() {
      isInit = false;
    });
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(initInput);

    setState(() {
      isEmpty = widget.controller.text.isEmpty;
    });

    _focus.addListener(() {
      setState(() {
        isFocused = _focus.hasFocus ? true : false;
      });
    });
    setState(() {
      isVisible = widget.obscureText;
      if (widget.validator != null) {
        validator = (e) {
          if (e != null) {
            return widget.validator!(e);
          }
          return widget.validator!(e);
        };
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(initInput);
  }

  @override
  void reassemble() {
    super.reassemble();
    setState(() {
      widget.controller.text =
          widget.controller.text.isEmpty ? '' : widget.controller.text;
      isFocused = false;
      isEmpty = widget.controller.text.isEmpty;
    });
  }

  void cok() {
    print("anjir");
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: inputKey,
      enabled: true,
      autovalidateMode: autovalidateMode,
      validator: (e) {
        if (widget.validator == null) {
          return null;
        }
        if (e != null) {
          return widget.validator!(e);
        }
        return widget.validator!(widget.controller.text);
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
                    style: widget.labelStyle ??
                        body3BTextStyle(color: ColorConstants.slate[700]),
                  ),
            widget.label == null
                ? Container()
                : SizedBox(height: widget.gap ?? 6.h),
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeIn,
              decoration: _renderBoxDecoration(state),
              child: Stack(
                children: [
                  TextField(
                    onTap: widget.onTap,
                    maxLines: widget.maxLines,
                    readOnly: widget.readOnly,
                    focusNode: _focus,
                    onChanged: (e) {
                      if (widget.onChange != null) {
                        widget.onChange!(e);
                      }
                      setState(() {
                        isEmpty = e.isEmpty ? true : false;
                      });
                      inputKey.currentState!.validate();
                    },
                    textAlignVertical: widget.prefixIcon != null
                        ? TextAlignVertical.center
                        : TextAlignVertical.top,
                    textInputAction: widget.textInputAction,
                    obscureText: isVisible,
                    keyboardType: widget.keyboardType,
                    decoration: _renderInputDecoration(state),
                    style: widget.textStyle ??
                        body3TextStyle(
                          color: state.errorText != null
                              ? Colors.red[400]
                              : ColorConstants.slate[900],
                          weight: FontWeight.w500,
                          letterSpacing: widget.obscureText ? 2.5 : null,
                        ),
                    controller: widget.controller,
                  ),
                  // _renderLabel(state),
                ],
              ),
            ),
            SizedBox(
              height: state.errorText != null || widget.hint != null ? 4.h : 0,
            ),
            state.errorText != null
                ? Text(
                    state.errorText ?? "",
                    style: body5BTextStyle(
                      color: Colors.red[400],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : widget.hint != null
                    ? Text(
                        widget.hint!,
                        style: body5TextStyle(
                          color: ColorConstants.slate[600],
                        ),
                      )
                    : Container(),
            SizedBox(height: widget.margin),
          ],
        );
      },
    );
  }

  Widget renderLabel(FormFieldState<String> state) {
    return widget.label != null
        ? AnimatedPositioned(
            top: isFocused || !isEmpty ? 9.h : 16.h,
            left: 16.w,
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            child: IgnorePointer(
              ignoring: true,
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 350),
                style: TextStyle(
                  color: state.errorText != null
                      ? ColorConstants.error
                      : ColorConstants.slate[900],
                  fontSize: isFocused || !isEmpty ? 10.sp : 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                child: Text(
                  widget.label!,
                ),
              ),
            ),
          )
        : Container();
  }

  BoxDecoration _renderBoxDecoration(FormFieldState<String> state) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8.w),
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
                    color: ColorConstants.primary[50]!.withOpacity(.4),
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
                    color: ColorConstants.primary[50]!.withOpacity(.4),
                    offset: Offset(0, 0),
                    blurRadius: 4,
                  ),
                ]
              : []),
    );
  }

  InputDecoration _renderInputDecoration(FormFieldState<String> state) {
    return InputDecoration(
      prefixIcon: widget.prefixIcon,
      prefix: widget.prefix,
      prefixIconColor: state.errorText != null ? ColorConstants.error : null,
      prefixIconConstraints: BoxConstraints.tight(
        widget.prefixConstraints ?? Size.square(40.w),
      ),
      prefixStyle: body5TextStyle(),
      suffixIconConstraints: BoxConstraints.tight(
        Size.square(40.w),
      ),
      hintStyle: widget.hintStyle ??
          body3TextStyle(
            weight:
                state.errorText != null ? FontWeight.w500 : FontWeight.normal,
            color: state.errorText != null
                ? ColorConstants.error
                : ColorConstants.slate[400],
            letterSpacing: 0,
          ),
      suffixIcon: widget.obscureText
          ? GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Icon(!isVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined),
            )
          : widget.suffixIcon,
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.w),
        borderSide: BorderSide.none,
      ),
      hintText: widget.placeholder,
      contentPadding: widget.padding ??
          EdgeInsets.symmetric(
            vertical: 13.h,
            horizontal: 14.w,
          ),
      isCollapsed: true,
    );
  }
}
