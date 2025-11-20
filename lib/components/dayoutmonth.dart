import 'package:flutter/material.dart';

class Dayoutmonth extends StatelessWidget {
  int day;

  Dayoutmonth({super.key, required this.day});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: .center,
      margin: .all(4),
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(50),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
        ],
      ),
      child: Text('${day + 1}'),
    );
  }
}
