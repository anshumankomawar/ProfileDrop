import 'package:flutter/material.dart';
import 'package:frontend/models/User.dart';
import 'UserCard.dart';

class UserScroller extends StatefulWidget {
  final User mainUser;
  final List<User> nearbyUsers;
  const UserScroller({Key? key, required this.mainUser, required this.nearbyUsers}) : super(key: key);

  @override
  State<UserScroller> createState() => _UserScrollerState();
}

class _UserScrollerState extends State<UserScroller> {
  List<User> nearbyUsers = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 260.0,
      child: ListView.builder(
        // This next line does the trick.

        scrollDirection: Axis.horizontal,
        itemCount: widget.nearbyUsers.length,
        itemBuilder: (context, index) {
          return UserCard(mainUser: widget.mainUser, user: widget.nearbyUsers[index]);
        },
      ),
    );
  }
}
