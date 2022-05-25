import 'package:flutter/material.dart';
import 'package:frontend/Database.dart';
import 'package:frontend/MapboxView.dart';
import 'package:frontend/UserAuth/LoginPage.dart';
import 'package:frontend/UserAuth/RegistrationPage.dart';
import 'BottomPanel.dart';
import 'Profile.dart';
import 'models/User.dart';
import 'SplashPanel.dart';

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
      initialRoute: '/splash',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/profile': (context) => const Profile(),
        '/registration': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage(),
        '/splash': (context) => const SplashPanel(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

// class HomePageArguments {
//   final User user;
//   HomePageArguments(this.user);
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<User> user;
  late List<User> nearbyUsers = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      return Container();
    } else {
      User user = args as User;
      return FutureBuilder(
          future: MongoDatabase.getNearbyUsers(user),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator
              return Container();
            } else {
              if (snapshot.hasError) {
                // Return error
                print("error" + snapshot.error.toString());
                return Container();
              } else {
                return Scaffold(
                  body: Center(
                      child:
                      Stack(
                          children: [
                            MapboxView(
                                user: user,
                                nearbyUsers: snapshot.data as List<User>
                            ),
                            BottomPanel(
                                user: user,
                                nearbyUsers: snapshot.data as List<User>
                            )
                          ]
                      )
                  ),
                );
              }
            }
          }
      );

    }
  }
}
