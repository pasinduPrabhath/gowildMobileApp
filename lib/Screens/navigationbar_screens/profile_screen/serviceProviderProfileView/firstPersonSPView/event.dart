class Event {
  final String title;
  final DateTime date;

  Event({required this.title, required this.date});

  @override
  String toString() => title;
}
