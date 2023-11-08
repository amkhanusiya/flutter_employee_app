import 'package:employee_app/i18n/strings.g.dart';
import 'package:employee_app/models/employee.dart';
import 'package:employee_app/utils/methods/aliases.dart';
import 'package:employee_app/utils/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

import 'app_date_picker.dart';

class AppDatePickerDialog extends StatefulWidget {
  final bool isEndDate;
  final String? date;
  final String firstDate;

  const AppDatePickerDialog(this.isEndDate, {this.date,this.firstDate="", super.key});

  @override
  State<AppDatePickerDialog> createState() => _AppDatePickerDialogState();
}

class _AppDatePickerDialogState extends State<AppDatePickerDialog> {
  DateTime? selectedDate;
  DateTime currentDate = DateTime.now();
  late DateTime nextMonday;
  late DateTime nextTuesday;
  late DateTime oneWeekLater;
  late DateTime firstDate;
  late DateTime lastDate;

  @override
  void initState() {
    firstDate = currentDate.subtract(const Duration(days: 365 * 2));
    lastDate = currentDate.add(const Duration(days: 365 * 2));

    nextMonday = currentDate.add(Duration(days: 7 - currentDate.weekday + 1));
    nextTuesday = nextMonday.add(const Duration(days: 1));
    oneWeekLater = currentDate.add(const Duration(days: 8));

    if (widget.date != null && widget.date!.isNotEmpty) {
      selectedDate = dateTime.toDateTime(widget.date);
    }
    if (widget.isEndDate && widget.firstDate.isNotEmpty) {
      firstDate = dateTime.toDateTime(widget.firstDate);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = Adaptive.w(80);
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width * 0.45,
                child: TextButton(
                  onPressed: () => setState(
                    () => widget.isEndDate
                        ? selectedDate = null
                        : selectedDate = currentDate,
                  ),
                  child: Text(widget.isEndDate
                      ? context.t.employee.calendar.no_date
                      : context.t.employee.calendar.today),
                ),
              ),
              SizedBox(
                width: width * 0.45,
                child: TextButton(
                  onPressed: () => setState(
                    () => widget.isEndDate
                        ? selectedDate = currentDate
                        : selectedDate = nextMonday,
                  ),
                  child: Text(
                    widget.isEndDate
                        ? context.t.employee.calendar.today
                        : context.t.employee.calendar.next_monday,
                  ),
                ),
              )
            ],
          ),
          !widget.isEndDate
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * 0.45,
                      child: TextButton(
                        onPressed: () =>
                            setState(() => selectedDate = nextTuesday),
                        child: Text(context.t.employee.calendar.next_tuesday),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.45,
                      child: TextButton(
                        onPressed: () =>
                            setState(() => selectedDate = oneWeekLater),
                        child: Text(context.t.employee.calendar.after_week),
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 20),
          AppDatePicker(
            initialDate: selectedDate ?? currentDate,
            firstDate: firstDate,
            lastDate: lastDate,
            onDateChanged: (dateTime) =>
                setState(() => selectedDate = dateTime),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    R.svg.calendar,
                    width: 20,
                  ),
                  SizedBox(width: Adaptive.dp(5)),
                  Text(
                    selectedDate != null
                        ? dateTime.formatDate(selectedDate!)
                        : context.t.employee.calendar.no_date,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                    child: Text(context.t.core.buttons.cancel),
                  ),
                  SizedBox(width: Adaptive.dp(10)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(selectedDate);
                    },
                    child: Text(context.t.core.buttons.save),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
