import 'package:intl/intl.dart';

String formattedShortDay(DateTime date) => DateFormat('E').format(date);
String formattedDay(DateTime date) => DateFormat('EEEE').format(date);
