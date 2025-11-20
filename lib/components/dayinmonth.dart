import 'package:flutter/material.dart';

class Dayinmonth extends StatelessWidget {
  int day;
  bool nowDay;

  Dayinmonth({super.key, required this.day, required this.nowDay});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: .center,
      margin: .all(4),
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        color: nowDay
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
        ],
      ),
      child: Text('${day + 1}'),
    );
  }
}
