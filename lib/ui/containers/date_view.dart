import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class DateViewWidget extends StatelessWidget {
  final ValueChanged<DateTime> dateChanged;
  final DateTime date;

  DateViewWidget({this.dateChanged, this.date});

  void handleNewDate(DateTime value) {
    if (value != null) {
      print("handleNewDate $value");
      dateChanged(value);
    }
  }

  // void handleDateRange(range) {
  //   if (range != null) {
  //     print("Range is ${range.item1}, ${range.item2}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Calendar(
        initialCalendarDateOverride: date,
        isExpandable: true,
        onDateSelected: handleNewDate,
      ),
    );
  }
}
