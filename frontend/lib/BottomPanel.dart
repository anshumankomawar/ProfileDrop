import 'package:frontend/Events/EventScroller.dart';
import 'package:frontend/Database.dart';
import 'package:frontend/models/Location.dart';
import 'package:frontend/models/User.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';

class BottomPanel extends StatefulWidget {
  const BottomPanel({Key? key}) : super(key: key);

  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  List<bool> isSelected = [true, false, false];
  List<String> dropdownValue = ["Active"];
  final double _panelHeightOpen = 800;
  final double _panelHeightClosed = 100.0;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panelSnapping: true,
      snapPoint: 0.5,
      maxHeight: _panelHeightOpen,
      minHeight: _panelHeightClosed,
      parallaxEnabled: true,
      parallaxOffset: .5,
      body: Container(),
      panelBuilder: (sc) => _panel(sc, isSelected, dropdownValue),
      borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(18.0),
          topRight: const Radius.circular(18.0)),
      onPanelSlide: (double pos) => setState(() {}),
    );
  }

  Widget _stateItem(String value, Color color) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          width: 12,
          height: 12,
          padding: const EdgeInsets.all(10),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
          ),
        )
      ],
    );
  }

  Widget _panel(
      ScrollController sc, List<bool> isSelected, List<String> dropdownValue) {
    List<String> _states = ["Active", "Inactive", "Friends", "Privacy"];
    List<MaterialColor> _colors = [
      Colors.green,
      Colors.yellow,
      Colors.blue,
      Colors.grey
    ];

    //User currentUser = User(id: , location: Location(id: ObjectId(), type: "type", coordinates: [-127, 140]), firstName: "firstName", lastName: "lastName", phoneNumber: "phoneNumber");
    // List<User> users = //getDocuments()
    // [
    //   User(
    //       id: ObjectId(), location: Location(id: ObjectId(), type: "type", coordinates: [-128, 141]), firstName: "firstName", lastName: "lastName", phoneNumber: "phoneNumber"),
    //   User(
    //       id: ObjectId(), location: Location(id: ObjectId(), type: "type", coordinates: [-128, 142]), firstName: "firstName", lastName: "lastName", phoneNumber: "phoneNumber"),
    //   User(
    //       id: ObjectId(), location: Location(id: ObjectId(), type: "type", coordinates: [128, 141]), firstName: "firstName", lastName: "lastName", phoneNumber: "phoneNumber"),
    // ];
    // users.sort((a,b) => (a.location.distanceTo(currentUser.location)).compareTo(b.location.distanceTo(currentUser.location)));
    // List<Card> items = [
    //   Card(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         const ListTile(
    //           leading: Icon(Icons.album),
    //           title: Text('"NAME"'),
    //           subtitle: Text('"CONVERSATIONSTARTER"'),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: <Widget>[
    //             TextButton(
    //               child: const Text('CONNECT'),
    //               onPressed: () {/* ... */},
    //             ),
    //             const SizedBox(width: 8),
    //             TextButton(
    //               child: const Text('MORE'),
    //               onPressed: () {/* ... */},
    //             ),
    //             const SizedBox(width: 8),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // ];
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SizedBox(
            height: _panelHeightClosed,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Richard Yu",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              width: 65,
                              height: 25,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  itemBuilder: (_, i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: _stateItem(_states[i], _colors[i]),
                                    );
                                  }),
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.only(top: 4.0),
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: const Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 32,
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: 10,
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
                    ),
                  ),
                  Flexible(flex: 2, child: EventScroller())
                ],
              ),
            )));
  }
}
