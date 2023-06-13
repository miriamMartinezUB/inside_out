import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/event_storage.dart';
import 'package:inside_out/resources/storage_keys.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarProvider extends ChangeNotifier {
  final FirebaseService firebaseService;
  final LocaleStorageService localeStorageService;
  late final EventsStorage _eventsStorage;
  late List<Event> selectedEvents;
  late LinkedHashMap<DateTime, List<Event>> _events;
  late DateTime _firstDay;

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  bool loading = true;

  final DateTime _today = DateTime.now();

  CalendarProvider({
    required this.firebaseService,
    required this.localeStorageService,
  }) {
    User user = User.fromJson(jsonDecode(localeStorageService.getString(StorageKeys.keyUser)));
    _eventsStorage = EventsStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _firstDay = user.registerDay;
    _getEvents();
  }

  DateTime get firstDay => _firstDay;

  set firstDay(value) => _firstDay = value;
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

  Future<void> _getEvents() async {
    _eventsStorage.all$.listen((events) {
      List<DateTime> days = [];
      DateTime startDay = _firstDay;
      if (isSameDay(startDay, _today)) {
        days.add(startDay);
      } else {
        while (!isSameDay(startDay, _today)) {
          days.add(startDay);
          startDay = startDay.add(const Duration(days: 1));
        }
        days.add(_today);
      }
      _events = LinkedHashMap<DateTime, List<Event>>(
        equals: isSameDay,
        hashCode: _getHashCode,
      )..addAll({for (DateTime day in days) day: events.where((element) => isSameDay(day, element.dateTime)).toList()});
      selectedEvents = getEventsForDay(selectedDay);
      loading = false;
      notifyListeners();
    });
  }

  List<Event> getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
