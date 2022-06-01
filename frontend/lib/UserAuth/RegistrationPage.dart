import 'package:flutter/material.dart';
import 'package:frontend/CustomTextInput.dart';
import 'package:frontend/Database.dart';
import 'package:frontend/models/Location.dart';
import 'package:frontend/models/User.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:geolocator/geolocator.dart' ;
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationPage extends StatefulWidget {
  final String inUsername;
  final String inPassword;
  const RegistrationPage(
      {Key? key, required this.inUsername, required this.inPassword})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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
    final username = TextEditingController();
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    final phoneNumber = TextEditingController();
    final password = TextEditingController();
    final passwordConfirm = TextEditingController();
    username.text = widget.inUsername;
    password.text = widget.inPassword;
    final _formKey = GlobalKey<FormState>();

    return Material(
      child: Form(
        key: _formKey,
        child: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 64, 0, 16),
            child: Text(
              "Registration",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomTextInput(
              inputController: username,
              validator: inputValidation,
              textName: "Username"),
          CustomTextInput(
              inputController: phoneNumber,
              validator: inputValidation,
              textName: "Phone Number"),
          CustomTextInput(
              inputController: firstName,
              validator: inputValidation,
              textName: "First Name"),
          CustomTextInput(
              inputController: lastName,
              validator: inputValidation,
              textName: "Last Name"),
          CustomTextInput(
              inputController: password,
              validator: inputValidation,
              textName: "Password"),
          CustomTextInput(
              inputController: passwordConfirm,
              validator: inputValidation,
              textName: "Confirm Password"),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: GestureDetector(
              onTap: () async {
                await MongoDatabase.connect();
                var user = await MongoDatabase.getUser(username.text);
                Position? position;
                try {
                  position = await _getGeoLocationPosition();
                } catch (e) {
                  Alert(context: context, title: "Error", desc: "Location permissions are currently denied. Please enable permissions by navigating to Settings > Drop > Location > Always.").show();
                }
                print(position);
                // Position position = await _getGeoLocationPosition();
                if (_formKey.currentState!.validate() && user == null && position != null) {
                  User user = User(
                    location: Location(
                        id: ObjectId(),
                        type: "Point",
                        coordinates: [position.longitude, position.latitude]),
                    username: username.text,
                    password: passwordConfirm.text,
                    firstName: firstName.text,
                    lastName: lastName.text,
                    phoneNumber: phoneNumber.text,
                    bio: "",
                    friends: [],
                    preferredStatus: 0,
                    socials: {},
                  );
                  await MongoDatabase.insert(user);
                  Navigator.popAndPushNamed(context, '/', arguments: user);
                }
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
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () async {
              Navigator.popAndPushNamed(context, '/splash');
            },
            child: const Text('Have an account? Login', 
              style: TextStyle(color: Color(0xFF472cdc))
            ),
          )
        ])),
      ),
    );
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

  String? inputValidation(String value, String textName) {
    if (value.isEmpty) {
      return "Please input a valid " + textName;
    }
    return null;
  }
}
