import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Database.dart';
import 'package:frontend/models/Location.dart';
import 'package:frontend/models/User.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;

class RegistrationPage extends StatefulWidget {
  final TextEditingController inUsername;
  final TextEditingController inPassword;
  const RegistrationPage(
      {Key? key, required this.inUsername, required this.inPassword})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final username = widget.inUsername;
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    final phoneNumber = TextEditingController();
    final password = widget.inPassword;
    final passwordConfirm = TextEditingController();

    return Material(
      child: Center(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 64, 0, 16),
          child: Text(
            "Registration Page",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: username,
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter a valid username';
            //   }
            //   return null;
            // },
            decoration: InputDecoration(
                hintText: "Username...",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: phoneNumber,
            // validator: (value) {
            //   if (value == null || value.isEmpty || isValidPhoneNumber(value)) {
            //     return 'Please enter a valid phone number';
            //   }
            //   return null;
            // },
            decoration: InputDecoration(
                hintText: "Phone Number...",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: firstName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter first name';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: "First Name...",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: lastName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: "Last Name...",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: "Password...",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: passwordConfirm,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: "Confirm Password...",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 32),
          ),
          onPressed: () async {
            await MongoDatabase.connect();
            var user = await MongoDatabase.getUser(username.text);
            if (user == null) {
              User user = User(
                location: Location(
                    id: ObjectId(),
                    type: "Point",
                    coordinates: [-120.6595, 35.2869]),
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
          child: const Text('Register'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () async {
            Navigator.popAndPushNamed(context, '/login');
          },
          child: const Text('Have an account? Login'),
        )
      ])),
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
}
