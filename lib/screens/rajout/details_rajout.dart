import 'package:flutter/material.dart';

class DetailsRajout extends StatefulWidget {
  final event;
  DetailsRajout({this.event});

  @override
  _DetailsRajoutState createState() => _DetailsRajoutState();
}

class _DetailsRajoutState extends State<DetailsRajout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails Rajout'),
      ),
    );
  }
}

