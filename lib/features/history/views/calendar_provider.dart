import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:inside_out/features/history/domain/event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarProvider extends ChangeNotifier {
  late List<Event> selectedEvents;
  late LinkedHashMap<DateTime, List<Event>> _events;
  late DateTime _firstDay;

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  final DateTime _today = DateTime.now();

  CalendarProvider() {
    // TODO: change _firstDay for the day of register of user
    _firstDay = DateTime(2023, 1, 1);
    _events = _getEvents();
    selectedEvents = getEventsForDay(selectedDay);
  }

  DateTime get firstDay => _firstDay;

  set firstDay(value) => _firstDay = value;

  List<Event> getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
      selectedEvents = getEventsForDay(selectedDay);
      notifyListeners();
    }
  }

  void onFormatChanged(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      notifyListeners();
    }
  }

  LinkedHashMap<DateTime, List<Event>> _getEvents() {
    return LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: _getHashCode,
    )..addAll(
        {
          for (var item in List.generate(50, (index) => index))
            DateTime.utc(_firstDay.year, _firstDay.month, item * 5):
                List.generate(item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
        }..addAll({
            //TODO change for real data
            _today: [
              const Event('Today\'s Event 1'),
              const Event('Today\'s Event 2'),
            ],
          }),
      );
  }

  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
