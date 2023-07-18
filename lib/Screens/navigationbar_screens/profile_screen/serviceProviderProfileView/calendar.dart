import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/profile_screen/serviceProviderProfileView/firstPersonSPView/event.dart';
import 'package:gowild/backend/api_requests/serviceProvider_api.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalender extends StatefulWidget {
  const CustomCalender({super.key});

  @override
  State<CustomCalender> createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  Map<DateTime, List<Event>> selectedEvents = {};
  late String? email;
  bool isLoading = true;
  String eventDetails = '';
  @override
  void initState() {
    _getEvents();
    super.initState();
  }

  Future<void> _getEvents() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? '';
    final res2 =
        await SpAPI.getCalender(email ?? '', '2020-06-01', '2300-12-31');
    print(res2);
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

  late DateTime selectedDate;
  CalendarFormat format = CalendarFormat.month;
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
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat format) {
                      setState(() {
                        format = format;
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
                  ..._getEventsfromDay(selectedDay).map(
                    (Event event) => ListTile(
                      title: Text(event.title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          final selectedEvent = _getEventsfromDay(selectedDay)
                              .firstWhere(
                                  (event) => event.title == event.title);
                          setState(() {
                            selectedEvents[selectedDay]?.remove(selectedEvent);
                          });
                          final success = await SpAPI.deleteCalender(
                              email,
                              DateFormat('yyyy-MM-dd').format(selectedDay),
                              selectedEvent.title);
                          if (success) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Event deleted'),
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Failed to delete event'),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                      ),
                    ),
                  )
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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'Add event',
          style: TextStyle(fontStyle: FontStyle.normal),
        ),
        icon: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add Event'),
            content: TextFormField(
              controller: _eventController,
              decoration: const InputDecoration(
                hintText: 'Add Event',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      eventDetails = _eventController.text;
                      selectedEvents[selectedDay]!.add(Event(
                          title: _eventController.text, date: selectedDay));
                    } else {
                      eventDetails = _eventController.text;
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text, date: selectedDay)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  final res = await SpAPI.updateCalender(
                      email,
                      DateFormat('yyyy-MM-dd')
                          .format(selectedEvents[selectedDay]![0].date),
                      eventDetails);
                  return;
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
