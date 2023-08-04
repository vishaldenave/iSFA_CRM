import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension Helper on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension BuildContextHelper on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}

extension FormatDate on DateTime {
  String toStringFormat(String format) {
    return DateFormat(format).format(this);
  }
}

extension FileExtention on FileSystemEntity {
  String? get name {
    return path.split(Platform.pathSeparator).last;
  }

  String get fileName {
    return basename(path);
  }
}
