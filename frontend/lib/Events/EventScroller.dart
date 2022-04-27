import 'package:flutter/material.dart';
import 'EventCard.dart';

class EventScroller extends StatefulWidget {
  const EventScroller({Key? key}) : super(key: key);

  @override
  State<EventScroller> createState() => _EventScrollerState();
}

class _EventScrollerState extends State<EventScroller> {
  List<String> eventNames = [
    "Event 1",
    "Event 2",
    "Event 3",
    "Event 4",
    "Event 5"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 200.0,
      child: ListView.builder(
        // This next line does the trick.

        scrollDirection: Axis.horizontal,
        itemCount: eventNames.length,
        itemBuilder: (context, index) {
          return EventCard(eventName: eventNames[index]);
        },
      ),
    );
  }
}
