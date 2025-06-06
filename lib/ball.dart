import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final ballX;
  final ballY;

  const Ball({super.key, required this.ballX, required this.ballY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
      ),
    );
  }
}
