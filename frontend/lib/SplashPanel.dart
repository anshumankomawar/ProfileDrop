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
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 24),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/registration');
            },
            child: const Text('Need an account? Register here.'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 24),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Already have an account? Login here.'),
          ),
        ])),
    );
  }
}
