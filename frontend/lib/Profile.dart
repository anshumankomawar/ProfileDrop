import 'package:flutter/material.dart';

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
                GestureDetector(
                  child: const Icon(Icons.save, size: 32),
                  onTap: () {
                    // const snackBar = SnackBar(
                    //   content: Text('Successfully saved user information'),
                    // );

                    // // Find the ScaffoldMessenger in the widget tree
                    // // and use it to show a SnackBar.
                    // Navigator.pop(context);
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
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
                  child: const Icon(Icons.person_add_alt_1_rounded, size: 100),
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
