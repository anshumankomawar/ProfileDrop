import 'package:flutter/material.dart';
import 'package:frontend/models/User.dart';
import 'Database.dart';

class OtherProfile extends StatefulWidget {
  final User mainUser;
  final User user;
  const OtherProfile({required this.mainUser, required this.user, Key? key}) : super(key: key);

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
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
                    "OtherProfile",
                    textScaleFactor: 1.5,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.add, size: 32),
                    onTap: () async { //todo add friend to main user
                      // if (_formKey.currentState!.validate()) {
                      //   // If the form is valid, display a snackbar. In the real world,
                      //   // you'd often call a server or save the information in a database.
                      //   await MongoDatabase.addFriend(user: widget.mainUser, friendId: widget.user.id);
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Added User')),
                      //   );
                      // }
                    },
                  ),
                ],
              ),
            ),
            _otherprofileFields(context)
          ]
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _otherprofileFields(BuildContext context) {
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
                  child: const Icon(Icons.person_outline, size: 100),
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
                        enabled: false,
                        // controller: firstName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                        initialValue: widget.user.firstName,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        enabled: false,
                        // controller: lastName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                        initialValue: widget.user.lastName,
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
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a location';
                      }
                      return null;
                    },
                    initialValue: widget.user.phoneNumber,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    enabled: false,
                    // controller: biography,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a bio';
                      }
                      return null;
                    },
                    initialValue: widget.user.phoneNumber,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
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
