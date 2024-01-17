import 'package:intl/intl.dart';

class Formatter {
  static String formatIntInMSs(int seconds) {
    final duration = Duration(seconds: seconds);
    final mm = (duration.inMinutes % 60).toString().padLeft(1, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$mm:$ss';
  }

  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  static String formatLargeNumber(int number) {
    if (number < 10000) {
      return number.toString();
    } else {
      double result = number / 10000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}만';
    }
  }

  static String convertToRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '방금';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${(difference.inDays / 7).round()}주 전';
    }
  }

  static String formatDateString(String inputDate,
      {bool onlyMonthDay = false}) {
    if (onlyMonthDay) {
      DateTime date = DateTime.parse(inputDate);
      return DateFormat('MM.dd').format(date);
    } else {
      DateTime date = DateTime.parse(inputDate);
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }
}
