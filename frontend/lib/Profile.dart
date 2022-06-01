import 'package:flutter/material.dart';
import 'package:frontend/Database.dart';
import 'package:frontend/models/Location.dart';
import 'package:frontend/models/User.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;

class Profile extends StatefulWidget {
  final User user;
  const Profile({required this.user, Key? key }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController bio = TextEditingController();

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
                GestureDetector(
                  child: const Icon(Icons.save, size: 32),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      User newUser = User(
                        location: widget.user.location,
                        username: widget.user.username,
                        password: widget.user.password,
                        firstName: firstName.text,
                        lastName: lastName.text,
                        phoneNumber: phoneNumber.text,
                        bio: bio.text,
                        friends: widget.user.friends,
                        preferredStatus: widget.user.preferredStatus,
                        PFP: widget.user.PFP,
                        college: widget.user.college,
                        major: widget.user.major,
                        job: widget.user.job,
                        song: widget.user.song,
                        socials: widget.user.socials
                      );

                      await MongoDatabase.update(newUser);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully saved user')),
                      );
                    }
                  },
                ),
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
    firstName.text = widget.user.firstName;
    lastName.text = widget.user.lastName;
    phoneNumber.text = widget.user.phoneNumber;
    bio.text = widget.user.bio;

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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://i.imgur.com/BoN9kdC.png")
                    )
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 30.0)),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
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
                          )
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
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
                    controller: phoneNumber,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a location';
                      }
                      return null;
                    },
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
                    controller: bio,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a bio';
                      }
                      return null;
                    },
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
