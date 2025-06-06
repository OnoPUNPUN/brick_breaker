import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool isStarted;

  const CoverScreen({super.key, required this.isStarted});

  @override
  Widget build(BuildContext context) {
    return isStarted
        ? Container()
        : Container(
            alignment: Alignment(0, -0.2),
            child: Text(
              'Tap To Play',
              style: TextStyle(
                color: Colors.green[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
