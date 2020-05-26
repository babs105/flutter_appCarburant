import 'package:flutter/material.dart';

class DetailsRavitaille extends StatefulWidget {
  final event;
  DetailsRavitaille({this.event});
  @override
  _DetailsRavitailleState createState() => _DetailsRavitailleState();
}

class _DetailsRavitailleState extends State<DetailsRavitaille> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails Ravitaillement'),
      ),
    );
  }
}

