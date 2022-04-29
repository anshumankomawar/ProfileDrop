import 'package:flutter/material.dart';
import 'package:frontend/Database.dart';
import 'package:frontend/MapboxView.dart';

import 'BottomPanel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => const  MyHomePage (),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/profile': (context) => const Profile(),
    },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.connect(),
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
              return Scaffold(
                body: Center(
                    child:
                        Stack(children: const [MapboxView(), BottomPanel()])),
              );
            }
          }
        });
  }
}

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 64.0, 32.0, 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Icon(Icons.arrow_back_rounded, size: 24),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Profile",
                  textScaleFactor: 1.5,
                ),
                const Icon(Icons.save, size: 32),
              ],
            ),
          ),
          _profileFields(context)
        ]
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _profileFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Icon(Icons.person_add_alt_1_rounded, size: 100),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(color: Colors.black)
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 30.0)),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "First Name...",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Last Name...",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Location...",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Bio...",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}