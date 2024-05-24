import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;
  Debouncer({required this.duration});
  Timer? _timer;
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(duration, action);
  }
}
