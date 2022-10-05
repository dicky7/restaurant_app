import 'package:intl/intl.dart';

class DateTimeHelper{
  static DateTime format(){
    // Date and Time Format
    final now = DateTime.now();
    final dateFormat = DateFormat('y/m/d');
    const timeSpecific = "08:00:00";
    final completeFormat = DateFormat('y/m/d H:m:s');

    //if scheduling not show make sure date format use ('y/m/d') not ('y/M/d')

    // Today Format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Tomorrow Format
    var formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}