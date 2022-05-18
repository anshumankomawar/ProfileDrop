import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPanel extends StatefulWidget {
  const SplashPanel({Key? key}) : super(key: key);

  @override
  State<SplashPanel> createState() => _SplashPanelState();
}

class _SplashPanelState extends State<SplashPanel> {
  @override
  Widget build(BuildContext context) {
    final password = TextEditingController();
    final username = TextEditingController();

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
                      color: Color(0xFFebebeb)
                    ),
                    child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value == null || value.isEmpty || isValidPhoneNumber(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      cursorColor: Color(0xFF472cdc),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Phone Number...",
                        hintStyle: TextStyle(
                          color: Color(0xFF472cdc).withOpacity(0.8)
                        ),
                        border: InputBorder.none
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        // )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFebebeb)
                    ),
                    child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      cursorColor: Color(0xFF472cdc),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Password...",
                        hintStyle: TextStyle(
                          color: Color(0xFF472cdc).withOpacity(0.8)
                        ),
                        border: InputBorder.none
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        // )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Color(0xFF472cdc).withOpacity(0.5),
                      //   style: BorderStyle.solid,
                      //   width: 1.5,
                      // ),
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
                    )
                  )
                ),
                const Padding(padding: EdgeInsets.fromLTRB(30, 50, 0, 50)),
                GestureDetector(
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
                      )
                    ),
                  )
                ),
              ],
            )
          ],
        )
      ),
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