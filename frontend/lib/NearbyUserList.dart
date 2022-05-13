import 'package:flutter/material.dart';
import 'package:frontend/Database.dart';
import 'models/User.dart';

class NearbyUserList extends StatefulWidget {
  final List<User> nearbyUsers;
  const NearbyUserList({required this.nearbyUsers, Key? key}) : super(key: key);

  @override
  State<NearbyUserList> createState() => _NearbyUserListState();
}

class _NearbyUserListState extends State<NearbyUserList> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: widget.nearbyUsers.length,
      itemBuilder: (context, idx) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text((widget.nearbyUsers[idx]).firstName + " " + (widget.nearbyUsers[idx]).lastName),
                subtitle: Text((widget.nearbyUsers[idx]).phoneNumber),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('CONNECT'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('MORE'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
