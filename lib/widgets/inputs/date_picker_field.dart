import 'package:blabla_project/theme/theme.dart';
import 'package:blabla_project/utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final DateTime initDate;
  final Function(DateTime) onDateSelected;

  const DatePickerField({super.key, required this.initDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.calendar_today, size: 16, color: BlaColors.neutral),
      title: Text(
        DateTimeUtils.formatDateTime(initDate),
        style: TextStyle( color: BlaColors.neutral)
      ),
      onTap: () => {
        // implement navigate to date picker full dialog, return pick date
      },
    );
  }
}
