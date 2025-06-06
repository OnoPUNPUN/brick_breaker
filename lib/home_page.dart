import 'dart:async';

import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';

import 'ball.dart';
import 'cover_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ball variables
  double ballX = 0;
  double ballY = 0;

  //player variables
  double playerX = 0;
  double playerWidth = 0.3;

  // Game settings
  bool isGameStarted = false;

  // Game methods
  void startGame() {
    isGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        ballY -= 0.01;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        body: Center(
          child: Stack(
            children: [
              //tap to play
              CoverScreen(isStarted: isGameStarted),
              //Ball
              Ball(ballX: ballX, ballY: ballY),
              // player
              Player(playerX: playerX, playerWidth: playerWidth),
            ],
          ),
        ),
      ),
    );
  }
}
