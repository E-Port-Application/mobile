import 'package:eport/styles/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showAlert(String msg, {bool? isSuccess = false}) {
  String slicedMsg = msg;
  if (slicedMsg.length > 60) {
    slicedMsg.substring(0, 60);
    slicedMsg += "...";
  }
  Fluttertoast.showToast(
    msg: slicedMsg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: isSuccess! ? Colors.green : Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showInfo(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ColorConstants.slate[800]!.withOpacity(.8),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
