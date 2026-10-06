import 'package:intl/intl.dart';

/// Locale-aware formatting helpers used throughout the app.
abstract final class Formatters {
  static final DateFormat _dayFull = DateFormat('EEEE, d MMMM y');
  static final DateFormat _dayShort = DateFormat('EEE, d MMM');
  static final DateFormat _dayNumeric = DateFormat('dd/MM/yyyy');
  static final DateFormat _time = DateFormat('h:mm a');
  static final DateFormat _dateTime = DateFormat('d MMM y, h:mm a');
  static final DateFormat _weekday = DateFormat('EEE');
  static final DateFormat _dateKey = DateFormat('yyyy-MM-dd');

  static String dayFull(DateTime d) => _dayFull.format(d);
  static String dayShort(DateTime d) => _dayShort.format(d);
  static String dayNumeric(DateTime d) => _dayNumeric.format(d);
  static String time(DateTime d) => _time.format(d);
  static String dateTime(DateTime d) => _dateTime.format(d);
  static String weekday(DateTime d) => _weekday.format(d);
  static String dateKey(DateTime d) => _dateKey.format(d);

  static String timeRange(DateTime start, DateTime end) =>
      '${time(start)} – ${time(end)}';

  static String money(num value, {String symbol = '৳', int decimals = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimals,
    ).format(value);
  }

  static String compactMoney(num value, {String symbol = '৳'}) {
    return '$symbol${NumberFormat.compact().format(value)}';
  }

  static String number(num value) => NumberFormat.decimalPattern().format(value);

  static String duration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    if (h == 0) return '${m}m';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  /// "Today", "Tomorrow", "Yesterday" or a short date.
  static String relativeDay(DateTime d, {DateTime? now}) {
    final today = DateUtilsX.startOfDay(now ?? DateTime.now());
    final target = DateUtilsX.startOfDay(d);
    final diff = target.difference(today).inDays;
    return switch (diff) {
      0 => 'Today',
      1 => 'Tomorrow',
      -1 => 'Yesterday',
      _ => dayShort(d),
    };
  }

  /// "5m ago", "2h ago", "3d ago".
  static String timeAgo(DateTime d, {DateTime? now}) {
    final diff = (now ?? DateTime.now()).difference(d);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 30) return '${diff.inDays}d ago';
    return dayNumeric(d);
  }

  static String initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}

/// Date arithmetic helpers.
abstract final class DateUtilsX {
  static DateTime startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

  static DateTime endOfDay(DateTime d) =>
      startOfDay(d).add(const Duration(days: 1));

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static DateTime combine(DateTime date, int hour, int minute) =>
      DateTime(date.year, date.month, date.day, hour, minute);

  /// Rounds [d] up to the next [minutes] boundary.
  static DateTime roundUp(DateTime d, {int minutes = 15}) {
    final remainder = d.minute % minutes;
    final base = DateTime(d.year, d.month, d.day, d.hour, d.minute);
    if (remainder == 0 && d.second == 0) return base;
    return base.add(Duration(minutes: minutes - remainder));
  }

  static bool overlaps(
    DateTime aStart,
    DateTime aEnd,
    DateTime bStart,
    DateTime bEnd,
  ) =>
      aStart.isBefore(bEnd) && bStart.isBefore(aEnd);
}
