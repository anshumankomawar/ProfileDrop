import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final phoneNumber = TextEditingController();
    final password = TextEditingController();
    return Material(
      child: Center(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 64, 0, 16),
          child: Text(
            "Login Page",
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
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 32),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: const Text('Login'),
        ),
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
