import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final String eventName;

  const EventCard({Key? key, required this.eventName}) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(3, 3), // changes position of shadow
            ),
          ],
        ),
        width: 160,
        child: Center(child: Text(widget.eventName)),
      ),
    );
  }
}
