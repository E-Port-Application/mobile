import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/scrollable_constraints.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:eport/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

typedef OnClick = void Function(PersonilState data);

class SearchDropdown extends StatefulWidget {
  final List<Rx<PersonilState>> options;
  final OnClick onClick;
  const SearchDropdown({
    super.key,
    required this.options,
    required this.onClick,
  });

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  TextEditingController searchInput = TextEditingController();
  bool show = false;
  bool opacityShow = false;
  List<PersonilState> options = <PersonilState>[];
  List<PersonilState> filteredOptions = <PersonilState>[];
  GlobalKey ref = GlobalKey();
  Offset offset = Offset.zero;
  Size size = Size(0, 0);

  @override
  void initState() {
    super.initState();
    setState(() {
      options = widget.options.map((e) => e.value).toList();
      filteredOptions = options;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOffset(ref);
    });
  }

  @override
  void didUpdateWidget(covariant SearchDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      options = widget.options.map((e) => e.value).toList();
      filteredOptions = options;
    });
  }

  void getOffset(GlobalKey ref) {
    RenderBox box = ref.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      offset = box.localToGlobal(Offset.zero);
      size = box.size;
    });
  }

  void handleToggle(bool e) async {
    if (!e) {
      setState(() {
        opacityShow = e;
      });
      await Future.delayed(Duration(milliseconds: 150));
    }

    setState(() {
      show = e;
    });
    if (e) {
      Future.delayed(Duration(milliseconds: 10)).then((_) {
        setState(() {
          opacityShow = e;
        });
      });
    }
  }

  void handleFilter(String val) {
    String truncedVal = val.toLowerCase().removeAllWhitespace;
    List<PersonilState> tempData = options.where((data) {
      String truncedStr = data.personil.name.toLowerCase().removeAllWhitespace;
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
    return PortalTarget(
      visible: show,
      portalFollower: Stack(
        children: [
          Positioned(
            left: 20.w,
            right: 20.w,
            top: offset.dy + size.height + 8.h,
            child: TapRegion(
              onTapOutside: (_) {
                handleToggle(false);
              },
              child: AnimatedOpacity(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 300),
                opacity: opacityShow ? 1 : 0,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 260.h,
                    minHeight: 120.h,
                  ),
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                    boxShadow: [ColorConstants.shadow[1]!],
                  ),
                  child: ScrollableConstraints(
                      physics: BouncingScrollPhysics(),
                      child: filteredOptions.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: filteredOptions
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        widget.onClick(e);
                                        handleToggle(false);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color:
                                                    ColorConstants.slate[200]!),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        height: 40.h,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            e.personil.name,
                                            style: body3TextStyle(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            )),
                ),
              ),
            ),
          ),
        ],
      ),
      child: AppInput(
        key: ref,
        controller: searchInput,
        placeholder: "Cari Nama PersonilModel",
        suffixIcon: Icon(Icons.search),
        onChange: (e) {
          final debouncer = Debouncer(duration: Duration(milliseconds: 200));
          debouncer.run(() {
            handleToggle(true);
            handleFilter(e);
          });
        },
        onTap: () {
          getOffset(ref);
          if (searchInput.text.isEmpty) {
            handleToggle(true);
          }
        },
      ),
    );
  }
}
