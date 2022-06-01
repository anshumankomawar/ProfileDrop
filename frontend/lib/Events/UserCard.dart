import 'package:flutter/material.dart';
import 'package:frontend/models/User.dart';

import '../OtherProfile.dart';

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({Key? key, required this.user})
      : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
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
                './lib/person.png',
              ),
              opacity: 0.8,
              fit: BoxFit.fitWidth
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
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.user.firstName + " " + widget.user.lastName + "\n",
                      style: const TextStyle(fontSize: 14.0)),
                    TextSpan(
                      text: widget.user.job,
                      style: const TextStyle(fontSize: 12.0)),
                  ],
                ),
              ),
            ),
          )),
        onTap: () {                       
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtherProfile(mainUser: widget.user, user: widget.user)),
          );
        }
      )
    );
  }
}
