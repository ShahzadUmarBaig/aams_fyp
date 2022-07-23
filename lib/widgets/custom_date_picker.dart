import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class TableComplexExample extends StatefulWidget {
  Function selectDate;
  Function? selectTime;
  DateTime kFirstDay;
  DateTime kLastDay;
  bool timeInputDisplay;
  Color? weekendColor;
  double? width;

  TableComplexExample(
    this.selectDate, {
    required this.kFirstDay,
    required this.kLastDay,
    this.selectTime,
    this.timeInputDisplay = false,
    this.weekendColor,
    this.width,
  });

  @override
  _TableComplexExampleState createState() => _TableComplexExampleState();
}

class _TableComplexExampleState extends State<TableComplexExample> {
  late final PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  late final ValueNotifier<List<Event>> _selectedEvents;
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool isPM = true;
  TextEditingController _hours = TextEditingController();
  TextEditingController _minutes = TextEditingController();
  @override
  void initState() {
    super.initState();
    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDays.clear();
      widget.selectDate(focusedDay);
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: widget.width ?? double.infinity,
      // margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // ValueListenableBuilder<DateTime>(
          //   valueListenable: _focusedDay,
          //   builder: (context, value, _) {
          //     return _CalendarHeader(
          //       focusedDay: value,
          //       clearButtonVisible: canClearSelection,
          //       onTodayButtonTap: () {
          //         setState(() => _focusedDay.value = DateTime.now());
          //       },
          //       lastYear: () {
          //         setState(() {
          //           if (DateTime(1950).year + 1 != value.year &&
          //               DateTime(1950).year != value.year) {
          //             DateTime current = value;
          //             setState(() => _focusedDay.value = DateTime(
          //                 current.year, current.month - 12, current.day));
          //           } else {
          //             setState(() => _focusedDay.value = DateTime(1950));
          //           }
          //         });
          //       },
          //       nextYear: () {
          //         setState(() {
          //           if (DateTime.now().year - 1 != value.year &&
          //               DateTime.now().year != value.year) {
          //             DateTime current = value;
          //             setState(() => _focusedDay.value = DateTime(
          //                 current.year, current.month + 12, current.day));
          //           } else {
          //             setState(() => _focusedDay.value = DateTime.now());
          //           }
          //         });
          //       },
          //       onClearButtonTap: () {
          //         setState(() {
          //           _rangeStart = null;
          //           _rangeEnd = null;
          //           _selectedDays.clear();
          //           _selectedEvents.value = [];
          //         });
          //       },
          //       onLeftArrowTap: () {
          //         _pageController.previousPage(
          //           duration: const Duration(milliseconds: 300),
          //           curve: Curves.easeOut,
          //         );
          //       },
          //       onRightArrowTap: () {
          //         _pageController.nextPage(
          //           duration: const Duration(milliseconds: 300),
          //           curve: Curves.easeOut,
          //         );
          //       },
          //     );
          //   },
          // ),
          Material(
            color: Colors.transparent,
            child: TableCalendar<Event>(
              firstDay: widget.kFirstDay,
              lastDay: widget.kLastDay,
              focusedDay: _focusedDay.value,
              headerVisible: false,
              selectedDayPredicate: (day) => _selectedDays.contains(day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                  isTodayHighlighted: false,
                  markerSizeScale: 0.12,
                  selectedTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontFamily: 'Poppins'),
                  weekendTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Poppins'),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  disabledTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: 'Poppins'),
                  outsideTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: 'Poppins'),
                  defaultTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Poppins'),
                  rangeHighlightScale: 0.10,
                  markerDecoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                  )),
              onDaySelected: _onDaySelected,

              // onRangeSelected: _onRangeSelected,
              onCalendarCreated: (controller) => _pageController = controller,
              onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() => _calendarFormat = format);
                }
              },
            ),
          ),

          // if (widget.timeInputDisplay)
          //   Column(
          //     children: [
          //       const Divider(
          //         height: 2,
          //         color: Colors.red,
          //       ),
          //       const SizedBox(
          //         height: 8.0,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Row(
          //             children: [
          //               Container(
          //                 width: 40,
          //                 height: 37,
          //                 decoration: BoxDecoration(
          //                     border: Border.all(color: Colors.grey),
          //                     borderRadius: BorderRadius.circular(10)),
          //                 child: TextField(
          //                   controller: _hours,
          //                   decoration: const InputDecoration(
          //                       hintText: "00",
          //                       border: InputBorder.none,
          //                       focusedBorder: InputBorder.none,
          //                       enabledBorder: InputBorder.none,
          //                       errorBorder: InputBorder.none,
          //                       disabledBorder: InputBorder.none,
          //                       contentPadding: EdgeInsets.only(
          //                           bottom: 15, left: 10, right: 10)),
          //                   keyboardType: TextInputType.number,
          //                   cursorColor: Colors.black,
          //                   style: const TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.black87,
          //                       fontFamily: 'Poppins'),
          //                   inputFormatters: <TextInputFormatter>[
          //                     FilteringTextInputFormatter.allow(
          //                         RegExp(r'[0-9]')),
          //                     LengthLimitingTextInputFormatter(2),
          //                   ], // Only numbers can be entered
          //                 ),
          //               ),
          //               const Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 3),
          //                 child: Text(
          //                   ':',
          //                   style: TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.pinkAccent,
          //                       fontFamily: 'Poppins'),
          //                 ),
          //               ),
          //               Container(
          //                 width: 40,
          //                 height: 37,
          //                 decoration: BoxDecoration(
          //                     border: Border.all(color: Colors.grey),
          //                     borderRadius: BorderRadius.circular(10)),
          //                 child: TextField(
          //                   controller: _minutes,
          //                   decoration: const InputDecoration(
          //                       hintText: "00",
          //                       border: InputBorder.none,
          //                       focusedBorder: InputBorder.none,
          //                       enabledBorder: InputBorder.none,
          //                       errorBorder: InputBorder.none,
          //                       disabledBorder: InputBorder.none,
          //                       contentPadding: EdgeInsets.only(
          //                           bottom: 15, left: 10, right: 10)),
          //                   keyboardType: TextInputType.number,
          //                   cursorColor: Colors.black,
          //                   style: const TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.black87,
          //                       fontFamily: 'Poppins'),
          //                   inputFormatters: <TextInputFormatter>[
          //                     FilteringTextInputFormatter.allow(
          //                         RegExp(r'[0-9]')),
          //                     LengthLimitingTextInputFormatter(2),
          //                   ], // Only numbers can be entered
          //                 ),
          //               ),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               InkWell(
          //                 onTap: () {
          //                   setState(() {
          //                     isPM = true;
          //                   });
          //                 },
          //                 child: Container(
          //                     decoration: BoxDecoration(
          //                         color: Colors.blue,
          //                         // color: isPM == true ? AppColors.secondaryBlue : AppColors.grayLight,
          //                         borderRadius: const BorderRadius.only(
          //                             topLeft: Radius.circular(10),
          //                             bottomLeft: Radius.circular(10))),
          //                     padding: const EdgeInsets.symmetric(
          //                         vertical: 8, horizontal: 15),
          //                     child: Text(
          //                       'PM',
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.white,
          //                           // color: isPM == true ? AppColors.white : AppColors.grayDark,
          //                           fontFamily: 'Poppins'),
          //                     )),
          //               ),
          //               InkWell(
          //                 onTap: () {
          //                   setState(() {
          //                     isPM = false;
          //                   });
          //                 },
          //                 child: Container(
          //                     decoration: BoxDecoration(
          //                         color: Colors.blue,
          //                         // color: isPM != true ? AppColors.secondaryBlue : AppColors.grayLight,
          //                         borderRadius: const BorderRadius.only(
          //                             topRight: Radius.circular(10),
          //                             bottomRight: Radius.circular(10))),
          //                     padding: const EdgeInsets.symmetric(
          //                         vertical: 8, horizontal: 15),
          //                     child: Text(
          //                       'AM',
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.white,
          //                           // color: isPM != true ? AppColors.white : AppColors.grayDark,
          //                           fontFamily: 'Poppins'),
          //                     )),
          //               ),
          //             ],
          //           ),
          //           InkWell(
          //             onTap: () {
          //               widget.selectTime!(_hours.text +
          //                   ':' +
          //                   _minutes.text +
          //                   (isPM ? ' PM' : ' AM'));
          //             },
          //             child: Container(
          //                 decoration: BoxDecoration(
          //                     color: Colors.blue,
          //                     borderRadius: BorderRadius.circular(10)),
          //                 padding: const EdgeInsets.symmetric(
          //                     vertical: 8, horizontal: 15),
          //                 child: const Text(
          //                   'CONFIRM',
          //                   style: TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white,
          //                       fontFamily: 'Poppins'),
          //                 )),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final VoidCallback lastYear;
  final VoidCallback nextYear;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.lastYear,
    required this.nextYear,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final month = DateFormat.MMMM().format(focusedDay);
    final year = DateFormat.y().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          // InkWell(onTap: () => lastYear.call(), child: Icon(Icons.arrow_back_ios)),
          // const SizedBox(
          //   width: 5.0,
          // ),
          // Text(
          //   year,
          //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
          // ),
          // const SizedBox(
          //   width: 5.0,
          // ),
          // InkWell(onTap: () => nextYear.call(), child: Icon(Icons.arrow_forward_ios)),
          // const Spacer(),
          InkWell(
            onTap: () => onLeftArrowTap.call(),
            child: Icon(Icons.arrow_back_ios),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Spacer(),
          Text(
            '$month, $year',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),
          ),
          Spacer(),

          const SizedBox(
            width: 5.0,
          ),
          InkWell(
            onTap: () => onRightArrowTap.call(),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
