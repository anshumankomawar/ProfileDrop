import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend/Database.dart';
import 'package:frontend/UserAuth/RegistrationPage.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/Location.dart';
import 'package:frontend/models/User.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:frontend/Constants.dart';

class SplashPanel extends StatefulWidget {
  const SplashPanel({Key? key}) : super(key: key);

  @override
  State<SplashPanel> createState() => _SplashPanelState();
}

class _SplashPanelState extends State<SplashPanel> {
  bool _passwordVisible = false;
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  TextEditingController password = TextEditingController();
  final username = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (AUTO_LOGIN == "true") {
      SchedulerBinding.instance?.addPostFrameCallback((_){
        _login();
      });
    }
  }

  _login() async {
    User user = User(
      location: Location(
          id: ObjectId(),
          type: "Point",
          coordinates: [-120.6595, 35.2869]),
      username: "isrickykorean",
      password: "sureheis",
      firstName: "Roman",
      lastName: "Black",
      phoneNumber: "1234567890",
      bio: "",
      friends: [],
      preferredStatus: 0,
      socials: {},
    );
    await MongoDatabase.connect();
    Navigator.popAndPushNamed(context, "/", arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Color(0xFF472cdc),
      color: Colors.white,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset("lib/drop-logos.jpeg"),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFebebeb)),
                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          isValidPhoneNumber(value)) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                    cursorColor: Color(0xFF472cdc),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Username...",
                        hintStyle: TextStyle(
                            color: Color(0xFF472cdc).withOpacity(0.8)),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFebebeb)),
                  child: TextFormField(
                    controller: password,
                    obscureText: _passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    cursorColor: Color(0xFF472cdc),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Password...",
                        hintStyle: TextStyle(
                            color: Color(0xFF472cdc).withOpacity(0.8)),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegistrationPage(
                          inUsername: username.text, inPassword: password.text),
                    ));
                    // Navigator.popAndPushNamed(context, '/registration',
                    //     arguments: {username, password});
                  },
                  child: Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF472cdc).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))),
              const Padding(padding: EdgeInsets.fromLTRB(30, 50, 0, 50)),
              GestureDetector(
                  onTap: () async {
                    await MongoDatabase.connect();
                    // print("Congrats on connecting.");
                    var user = await MongoDatabase.getUser(username.text);
                    // print("This is the gotten user:");
                    // print(user);
                    if (user == null) {
                      print("User does not exist.");
                    } else {
                      if (user.password == password.text) {
                        Navigator.popAndPushNamed(context, '/',
                            arguments: user);
                      } else {
                        print("Incorrect password.");
                        // TODO
                      }
                    }
                  },
                  child: Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF472cdc),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                        child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  )),
            ],
          )
        ],
      )),
    );
  }
}

bool isValidPhoneNumber(String value) {
  List numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  int count = 0;
  for (int i = 0; i < value.length; i++) {
    if (numbers.contains(value[i])) {
      count += 1;
    }
  }
  return count == 10;
}
