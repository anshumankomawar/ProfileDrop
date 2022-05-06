import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final String eventName;
  final DateTime eventDate;

  const EventCard({Key? key, required this.eventName, required this.eventDate})
      : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    DateFormat timeFormat = DateFormat('hh:mm a');
    String eventTime = timeFormat.format(widget.eventDate);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(3, 3), // changes position of shadow
                ),
              ],
              image: const DecorationImage(
                image: AssetImage(
                  './lib/Events/parkimage.jpg',
                ),
                opacity: 0.8,
                fit: BoxFit.fill,
              ),
            ),
            width: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.eventName + "\n",
                          style: const TextStyle(fontSize: 18.0)),
                      TextSpan(
                          text:
                              DateFormat.MMMMEEEEd().format(widget.eventDate) +
                                  "\n",
                          style: const TextStyle(fontSize: 16.0)),
                      TextSpan(
                          text: eventTime,
                          style: const TextStyle(fontSize: 14.0)),
                    ],
                  ),
                ),
              ),
            )));
  }
}
