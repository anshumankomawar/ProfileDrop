import 'package:flutter/material.dart';
import 'EventCard.dart';

class EventScroller extends StatefulWidget {
  const EventScroller({Key? key}) : super(key: key);

  @override
  State<EventScroller> createState() => _EventScrollerState();
}

class _EventScrollerState extends State<EventScroller> {
  List<String> eventNames = [
    "Shakespeare at The Park",
    "Robespierre at The Park",
    "Thoreau at The Park",
    "Emerson at The Park",
    "Erdös at The Park"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 240.0,
      child: ListView.builder(
        // This next line does the trick.

        scrollDirection: Axis.horizontal,
        itemCount: eventNames.length,
        itemBuilder: (context, index) {
          return EventCard(
              eventName: eventNames[index], eventDate: DateTime.now());
        },
      ),
    );
  }
}
