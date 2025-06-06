import 'dart:async';

import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ball.dart';
import 'cover_screen.dart';
import 'game_over_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Direction { up, down }

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  //ball variables
  double ballX = 0;
  double ballY = 0;
  var ballDirection = Direction.down;

  //player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Game settings
  bool isGameStarted = false;
  bool isGameOver = false;

  // Game methods
  void startGame() {
    isGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // UPDATE BALL DIRECTION
      updateDirection();
      // MOVE BALL DIRECTION
      moveBall();

      // check game end or not
      if (isPlayerDead()) {
        timer.cancel();
        setState(() {
          isGameOver = true;
        });
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballDirection == Direction.down) {
        ballY += 0.01;
      } else if (ballDirection == Direction.up) {
        ballY -= 0.01;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballDirection = Direction.up;
      } else if (ballY <= -0.9) {
        ballDirection = Direction.down;
      }
    });
  }

  // GAME OVER
  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  //Moving Logic by key
  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 <= -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            moveLeft();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            moveRight();
          }
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.green[100],
          body: Center(
            child: Stack(
              children: [
                //tap to play
                CoverScreen(isStarted: isGameStarted),

                // game over screen
                GameOverScreen(isGameOver: isGameOver),

                //Ball
                Ball(ballX: ballX, ballY: ballY),
                // player
                Player(playerX: playerX, playerWidth: playerWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
