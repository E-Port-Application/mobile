import 'package:flutter/material.dart';

void showLoadingState(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      );
    },
  );
}
