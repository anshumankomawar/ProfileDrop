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
      child: Container(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 48),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    textStyle:
                        const TextStyle(fontSize: 24, color: Colors.grey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        side: BorderSide(color: Colors.lightBlueAccent)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration');
                  },
                  child: const Text('Sign up'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    textStyle:
                        const TextStyle(fontSize: 24, color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side: BorderSide(color: Colors.lightBlueAccent),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Log in'),
                ),
              ),
            ]),
      )),
    );
  }
}
