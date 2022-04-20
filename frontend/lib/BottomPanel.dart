import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';

class BottomPanel extends StatefulWidget {
  const BottomPanel({Key? key}) : super(key: key);

  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final double _panelHeightOpen = 400;
  final double _panelHeightClosed = 100.0;


  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panelSnapping: true,
      snapPoint: 0.5,
      maxHeight: _panelHeightOpen,
      minHeight: _panelHeightClosed,
      parallaxEnabled: true,
      parallaxOffset: .5,
      body: Container(),
      panelBuilder: (sc) => _panel(sc),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0)),
      onPanelSlide: (double pos) => setState(() {
      }),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SizedBox(
          height: _panelHeightClosed,
            child: Center(
                child: const Text("This is the panel.")))
    );
  }
}
