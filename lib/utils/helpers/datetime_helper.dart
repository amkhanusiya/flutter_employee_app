import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@singleton
class DateTimeHelper {
  final dateFormatter = DateFormat('dd MMM yyyy');

  String formatDate(DateTime dateTime) {
    return dateFormatter.format(dateTime);
  }

  DateTime toDateTime(String? dateTime) {
    return dateFormatter.parse(dateTime!);
  }
}
