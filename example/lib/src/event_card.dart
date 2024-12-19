import 'package:example/src/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event eventData;

  const EventCard({
    super.key,
    required this.eventData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(eventData.name),
        Text(DateFormat.Hms().format(eventData.timestamp.toLocal()))
      ],
    );
  }
}