import 'package:intl/intl.dart';

class Utils {
  static formatDate(String date) {
    print(date);
    final formattedDate = DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
    return formattedDate;
  }
}
