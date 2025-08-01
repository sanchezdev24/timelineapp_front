class DateUtils {
  static String formatDateRange(DateTime start, DateTime? end) {
    if (end != null) {
      return '${_formatDate(start)} - ${_formatDate(end)}';
    }
    return _formatDate(start);
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static bool isDateInRange(DateTime date, DateTime start, DateTime end) {
    return date.isAfter(start.subtract(const Duration(days: 1))) &&
        date.isBefore(end.add(const Duration(days: 1)));
  }
}
