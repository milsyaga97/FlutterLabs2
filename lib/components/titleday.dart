import 'package:flutter/material.dart';

class TitleDay extends StatelessWidget {
  String title;

  TitleDay({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(child: Text(title, style: TextStyle(fontSize: 12))),
    );
  }
}
