


import 'package:flutter/material.dart';

class RealTimeScreen extends StatefulWidget {
  @override
  _RealTimeScreenState createState() => _RealTimeScreenState();
}

class _RealTimeScreenState extends State<RealTimeScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("RealTime"),),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
