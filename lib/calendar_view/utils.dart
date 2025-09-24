import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color getRandomColor() =>
    Colors.primaries[Random().nextInt(Colors.primaries.length)];

final timeFormat = DateFormat('ha');
final timeFormat2 = DateFormat('HH:mm');
final dayFormat = DateFormat('EEE');
final dayDateFormat = DateFormat('dd');

final rd = Random();


bool isSameDate(DateTime a, DateTime b) {
  return a.year == b.year &&
      a.month == b.month &&
      a.day == b.day;
}
