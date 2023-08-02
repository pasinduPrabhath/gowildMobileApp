import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/profile_screen/serviceProviderProfileView/firstPersonSPView/event.dart';
import 'package:gowild/backend/api_requests/serviceProvider_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class ThirdPersonViewCalendar extends StatefulWidget {
  final String email;
  const ThirdPersonViewCalendar({
    super.key,
    required this.email,
  });

  @override
  State<ThirdPersonViewCalendar> createState() =>
      _ThirdPersonViewCalendarState();
}

class _ThirdPersonViewCalendarState extends State<ThirdPersonViewCalendar> {
  Map<DateTime, List<Event>> selectedEvents = {};

  bool isLoading = true;
  String eventDetails = '';
  @override
  void initState() {
    _getEvents();
    super.initState();
  }

  Future<void> _getEvents() async {
    // final prefs = await SharedPreferences.getInstance();
    // email = prefs.getString('email') ?? '';
    final res2 =
        await SpAPI.getCalender(widget.email, '2020-06-01', '2300-12-31');

    setState(() {
      isLoading = true;
      selectedEvents = {
        for (var e in res2)
          DateTime.parse(e['event_date']): [
            Event(
                title: e['event_details'],
                date: DateTime.parse(e['event_date']))
          ]
      };
      isLoading = false;
    });
  }

  CalendarFormat formats = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final TextEditingController _eventController = TextEditingController();
  List<Event> _getEventsfromDay(DateTime date) {
    final events = selectedEvents[date] ?? [];
    return events;
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calender'),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await _getEvents();
              setState(() {
                isLoading = false;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  TableCalendar(
                    focusedDay: selectedDay,
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2050),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarFormat: formats,
                    onFormatChanged: (CalendarFormat format) {
                      setState(() {
                        formats = format;
                      });
                    },
                    daysOfWeekVisible: true,
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                        // print(focusedDay);
                      });
                    },
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                      todayDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      defaultDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      weekendDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    eventLoader: _getEventsfromDay,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 28.0),
                    child: Text('⚫️ represents the busy dates'),
                  ),
                ],
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black
                  .withOpacity(0.65), // Set the color to transparent black
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
