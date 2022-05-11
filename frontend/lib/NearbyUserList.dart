import 'package:flutter/material.dart';
import 'package:frontend/Database.dart';
import 'models/User.dart';

class NearbyUserList extends StatefulWidget {
  final User user;
  const NearbyUserList({required this.user, Key? key}) : super(key: key);

  @override
  State<NearbyUserList> createState() => _NearbyUserListState();
}

class _NearbyUserListState extends State<NearbyUserList> {
  @override
  Widget build(BuildContext context) {
    print("BUILDING");
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text("first" + " " + "last"),
                subtitle: Text("phone"),
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
    return FutureBuilder(
        future: MongoDatabase.getNearbyUsers(widget.user.location.coordinates),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator
            return Container();
          } else {

            if (snapshot.hasError) {
              // Return error
              print("ERHERE");
              return Container();
            } else {
              // Return Listview with documents data

            }
          }
        });
  }
}
