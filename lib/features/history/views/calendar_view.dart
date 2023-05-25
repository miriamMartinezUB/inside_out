import 'package:flutter/material.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/features/history/views/calendar_provider.dart';
import 'package:inside_out/features/history/views/event_view.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalendarProvider calendarProvider = CalendarProvider();
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final TextStyle tinyTextStyle = getTextStyle(paletteColors: paletteColors, type: TextTypes.tinyBody);
    final TextStyle smallTextStyle = getTextStyle(paletteColors: paletteColors, type: TextTypes.smallBody);

    return ChangeNotifierProvider<CalendarProvider>(
      create: (BuildContext context) => calendarProvider,
      child: Consumer<CalendarProvider>(
        builder: (context, calendarProvider, child) {
          return Column(
            children: [
              TableCalendar<Event>(
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: tinyTextStyle,
                  weekendStyle: tinyTextStyle,
                ),
                locale: Provider.of<LanguageService>(context).currentLanguageCode,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: getTextStyle(paletteColors: paletteColors),
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    color: paletteColors.text,
                    size: Dimens.iconSmall,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: paletteColors.text,
                    size: Dimens.iconSmall,
                  ),
                ),
                firstDay: calendarProvider.firstDay,
                lastDay: DateTime.now(),
                focusedDay: calendarProvider.focusedDay,
                selectedDayPredicate: (day) => isSameDay(calendarProvider.selectedDay, day),
                calendarFormat: calendarProvider.calendarFormat,
                eventLoader: calendarProvider.getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: paletteColors.text.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(Dimens.radiusLarge),
                  ),
                  todayDecoration: BoxDecoration(
                    color: paletteColors.primary.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: paletteColors.primary,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                  defaultTextStyle: smallTextStyle,
                  weekendTextStyle: smallTextStyle,
                  disabledTextStyle: getTextStyle(
                    paletteColors: paletteColors,
                    type: TextTypes.smallBody,
                    color: paletteColors.textSubtitle.withOpacity(0.5),
                  ),
                  selectedTextStyle: getTextStyle(
                    paletteColors: paletteColors,
                    type: TextTypes.smallBody,
                    color: paletteColors.textButton,
                  ),
                ),
                onDaySelected: calendarProvider.onDaySelected,
                onFormatChanged: calendarProvider.onFormatChanged,
                onPageChanged: (focusedDay) => calendarProvider.focusedDay = focusedDay,
              ),
              const SizedBox(height: 8.0),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: calendarProvider.selectedEvents.length,
                itemBuilder: (context, index) {
                  return CardEventView(event: calendarProvider.selectedEvents[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
