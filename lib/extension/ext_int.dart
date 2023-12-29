import 'package:intl/intl.dart';

extension IntExtension on int {
  String formatPrice() {
    return NumberFormat('#,###.##').format(this);
  }
}