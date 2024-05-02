import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ExtNumber on num {
  String formatDate({
    String? valDefault,
    String? format,
  }) {
    try {
      final time = double.tryParse(toString()) ?? 0;
      if (time <= 0) {
        return valDefault ?? '';
      }
      return DateFormat(format ?? 'dd/MM/yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(time.round() * 1000));
    } catch (e) {
      return valDefault ?? '';
    }
  }

  String formatPrice({String type = ''}) {
    if ((this) < 0) {
      return '0$type';
    }
    final formatCurrency = NumberFormat('#,###,###.##', 'vi');
    final format = formatCurrency.format(this);
    return format + type;
  }

  BorderRadius get radius => BorderRadius.circular(toDouble());

  BorderRadius get radiusTop =>
      BorderRadius.vertical(top: Radius.circular(toDouble()));

  BorderRadius get radiusBottom =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble()));

  Widget get height => SizedBox(height: toDouble());

  Widget get width => SizedBox(width: toDouble());

  EdgeInsets get paddingTop => EdgeInsets.only(top: toDouble());

  EdgeInsets get paddingLeft => EdgeInsets.only(left: toDouble());

  EdgeInsets get paddingRight => EdgeInsets.only(right: toDouble());

  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: toDouble());

  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get padding => EdgeInsets.all(toDouble());

  Duration get milliseconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());
}

extension ExtNumOrNull on num? {
  num get validator => this ?? 0;
}
