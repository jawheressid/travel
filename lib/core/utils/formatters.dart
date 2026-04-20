import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  final formatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'TND ',
    decimalDigits: 0,
  );
  return formatter.format(amount);
}

String formatDateRange(DateTime start, DateTime end) {
  final formatter = DateFormat('MMM d');
  return '${formatter.format(start)} - ${formatter.format(end)}';
}

String formatLongDate(DateTime value) {
  return DateFormat('MMMM d, y').format(value);
}
