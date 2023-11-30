import 'package:employee_management/core/constants/constants.dart';
import 'package:employee_management/core/utils/date_time_ext.dart';
import 'package:employee_management/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatePickerDialog extends StatefulWidget {
  final DateTime? fromDateTime;
  final DateTime? toDateTime;
  final bool selectingFromDate;

  const CustomDatePickerDialog(
      this.fromDateTime, this.toDateTime, this.selectingFromDate,
      {super.key});

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  int increment = 0;
  DateTime? date;
  SelectedType selectedType = SelectedType.today;

  @override
  Widget build(BuildContext context) {
    if (widget.selectingFromDate &&
        date == null &&
        selectedType != SelectedType.none) {
      date = widget.fromDateTime;
    }
    if (!widget.selectingFromDate &&
        date == null &&
        selectedType != SelectedType.nodate) {
      date = widget.toDateTime;
    }

    return Dialog(
        child: Wrap(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: [
                widget.selectingFromDate
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 24, left: 16, right: 16),
                        child: Row(
                          children: [
                            Flexible(
                              child: (selectedType == SelectedType.today)
                                  ? CustomButton(
                                      () {
                                        setState(() {
                                          date = DateTime.now();
                                          selectedType = SelectedType.today;
                                        });
                                      },
                                      "Today",
                                      backgroundColor:
                                          const Color.fromRGBO(29, 161, 242, 1),
                                      textColor: Colors.white,
                                    )
                                  : CustomButton(() {
                                      setState(() {
                                        date = DateTime.now();
                                        selectedType = SelectedType.today;
                                      });
                                    }, "Today"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: (selectedType == SelectedType.nextMonday)
                                  ? CustomButton(
                                      () {
                                        setState(() {
                                          date = DateTime.now()
                                              .next(DateTime.monday);
                                          selectedType =
                                              SelectedType.nextMonday;
                                        });
                                      },
                                      "Next Monday",
                                      backgroundColor:
                                          const Color.fromRGBO(29, 161, 242, 1),
                                      textColor: Colors.white,
                                    )
                                  : CustomButton(() {
                                      setState(() {
                                        date = DateTime.now()
                                            .next(DateTime.monday);
                                        selectedType = SelectedType.nextMonday;
                                      });
                                    }, "Next Monday"),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 24, left: 16, right: 16),
                        child: Row(
                          children: [
                            Flexible(
                              child: (selectedType == SelectedType.nodate)
                                  ? CustomButton(
                                      () {
                                        setState(() {
                                          date = null;
                                          selectedType = SelectedType.nodate;
                                        });
                                      },
                                      "No date",
                                      backgroundColor:
                                          const Color.fromRGBO(29, 161, 242, 1),
                                      textColor: Colors.white,
                                    )
                                  : CustomButton(() {
                                      setState(() {
                                        date = null;
                                        selectedType = SelectedType.nodate;
                                      });
                                    }, "No date"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: (selectedType == SelectedType.today)
                                  ? CustomButton(
                                      () {
                                        setState(() {
                                          date = DateTime.now();
                                          selectedType = SelectedType.today;
                                        });
                                      },
                                      "Today",
                                      backgroundColor:
                                          const Color.fromRGBO(29, 161, 242, 1),
                                      textColor: Colors.white,
                                    )
                                  : CustomButton(() {
                                      setState(() {
                                        date = DateTime.now();
                                        selectedType = SelectedType.today;
                                      });
                                    }, "Today"),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 16,
                ),
                widget.selectingFromDate
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: [
                            Flexible(
                                child: (selectedType ==
                                        SelectedType.nextTuesday)
                                    ? CustomButton(
                                        () {
                                          setState(() {
                                            date = DateTime.now()
                                                .next(DateTime.tuesday);
                                            selectedType =
                                                SelectedType.nextTuesday;
                                          });
                                        },
                                        "Next Tuesday",
                                        backgroundColor: const Color.fromRGBO(
                                            29, 161, 242, 1),
                                        textColor: Colors.white,
                                      )
                                    : CustomButton(() {
                                        setState(() {
                                          date = DateTime.now()
                                              .next(DateTime.tuesday);
                                          selectedType =
                                              SelectedType.nextTuesday;
                                        });
                                      }, "Next Tuesday")),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: (selectedType == SelectedType.afterOneWeek)
                                  ? CustomButton(
                                      () {
                                        setState(() {
                                          date = DateTime.now()
                                              .add(const Duration(days: 7));
                                          selectedType =
                                              SelectedType.afterOneWeek;
                                        });
                                      },
                                      "After 1 week",
                                      backgroundColor:
                                          const Color.fromRGBO(29, 161, 242, 1),
                                      textColor: Colors.white,
                                    )
                                  : CustomButton(() {
                                      setState(() {
                                        date = DateTime.now()
                                            .add(const Duration(days: 7));
                                        selectedType =
                                            SelectedType.afterOneWeek;
                                      });
                                    }, "After 1 week"),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TableCalendar(
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: const CalendarStyle(
                        weekNumberTextStyle: TextStyle(fontSize: 10),
                        markersMaxCount: 1,
                        selectedTextStyle: TextStyle(color: Colors.white),
                        selectedDecoration: BoxDecoration(
                            color: Color.fromRGBO(29, 161, 242, 1),
                            shape: BoxShape.circle),
                        todayTextStyle:
                            TextStyle(color: Color.fromRGBO(29, 161, 242, 1)),
                        todayDecoration:
                            BoxDecoration(color: Colors.transparent)),
                    onDaySelected: (ondate, value) {
                      setState(() {
                        date = ondate;
                        if (date!.isSameDate(DateTime.now())) {
                          selectedType = SelectedType.today;
                        } else if (date!
                            .isSameDate(DateTime.now().next(DateTime.monday))) {
                          selectedType = SelectedType.nextMonday;
                        } else if (date!.isSameDate(
                            DateTime.now().next(DateTime.tuesday))) {
                          selectedType = SelectedType.nextTuesday;
                        } else if (date!.isSameDate(
                            DateTime.now().add(const Duration(days: 7)))) {
                          selectedType = SelectedType.afterOneWeek;
                        } else {
                          selectedType = SelectedType.none;
                        }
                      });
                    },
                    firstDay: DateTime.now()
                        .subtract(const Duration(days: 365 * 100)),
                    lastDay: DateTime.now().add(const Duration(days: 365)),
                    focusedDay: date ?? DateTime.now(),
                    currentDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      if (date != null) {
                        if (day.isSameDate(date!)) {
                          return true;
                        }
                      }
                      return false;
                    },
                  ),
                ),
                const Divider(
                  height: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, left: 16, right: 16, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: SvgPicture.asset(AssetPaths.dateIcon),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              date != null ? date!.formatDate() : "No date",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: CustomButton(() {
                        Navigator.pop(context);
                      }, "Cancel")),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                          flex: 1,
                          child: CustomButton(
                            () {
                              Navigator.pop(context, date);
                            },
                            "Save",
                            backgroundColor:
                                const Color.fromRGBO(29, 161, 242, 1),
                            textColor: Colors.white,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

enum SelectedType { today, nextMonday, nextTuesday, afterOneWeek, nodate, none }
