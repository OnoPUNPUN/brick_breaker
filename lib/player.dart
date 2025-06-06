import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double playerX;
  final double playerWidth;

  const Player({super.key, required this.playerX, required this.playerWidth});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddleWidth = screenWidth * (playerWidth / 2); // FIXED
    double paddleLeft = (screenWidth / 2) * (playerX + 1) - (paddleWidth / 2);

    return Positioned(
      bottom: 30,
      left: paddleLeft.clamp(0, screenWidth - paddleWidth),
      child: Container(
        width: paddleWidth,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
