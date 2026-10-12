import 'package:intl/intl.dart';

final _thousands = NumberFormat('#,##0');

String formatAmount(int amount) => _thousands.format(amount);

String formatMoney(int amount, {String symbol = 'NT\$'}) => '$symbol ${formatAmount(amount)}';

const _weekdays = ['一', '二', '三', '四', '五', '六', '日'];

/// 10/12（日）
String formatDayHeader(DateTime d) => '${d.month}/${d.day}（${_weekdays[d.weekday - 1]}）';

bool isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
