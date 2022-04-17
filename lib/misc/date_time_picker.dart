import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onChanged;
  const DateTimePicker({Key? key, required this.onChanged, this.initialDate})
      : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime selectedDate;

  Future<void> _selectTime(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1948, 3, 15),
        lastDate: DateTime(9999, 1, 1));
    if (date != null) {
      TimeOfDay time = await showTimePicker(
              context: context, initialTime: TimeOfDay.now()) ??
          TimeOfDay.fromDateTime(selectedDate);
      selectedDate =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      widget.onChanged(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = widget.initialDate ?? DateTime.now();
    return ElevatedButton(
        onPressed: () {
          _selectTime(context);
        },
        child: const Icon(Icons.calendar_month));
  }
}
