import 'dart:async';

import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ball.dart';
import 'bricks.dart';
import 'cover_screen.dart';
import 'game_over_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Direction { up, down, left, right }

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  //brick variables
  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4;
  double brickHeight = 0.1;
  bool isBrickBreak = false;

  //ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXSides = 0.01;
  double ballYSides = 0.01;
  var ballYDirection = Direction.down;
  var ballXDirection = Direction.left;

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
      // is brick break
    });
  }

  void checkBrokenBricks() {
    if (ballX >= brickX &&
        ballX <= brickX + brickWidth &&
        ballY >= brickY + brickWidth &&
        isBrickBreak == false) {
      setState(() {
        isBrickBreak = true;
        ballYDirection = Direction.down;
      });
    }
  }

  void moveBall() {
    // move ball horizontally
    setState(() {
      if (ballXDirection == Direction.left) {
        ballX -= ballXSides;
      } else if (ballXDirection == Direction.right) {
        ballX += ballXSides;
      }
    });

    //move ball vertically
    setState(() {
      if (ballYDirection == Direction.down) {
        ballY += ballYSides;
      } else if (ballYDirection == Direction.up) {
        ballY -= ballYSides;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.up;
      } else if (ballY <= -1) {
        ballYDirection = Direction.down;
      }

      if(ballX >= 1){
        ballXDirection = Direction.left;
      } else if(ballX <= -1){
        ballXDirection = Direction.right;
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
  void moveRight() {
    setState(() {
      if (playerX + 0.2 + playerWidth <= 2) {
        playerX += 0.2;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (playerX - 0.2 >= -1) {
        playerX -= 0.2;
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

                //bricks
                Bricks(
                  brickX: brickX,
                  brickY: brickY,
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickBreak: isBrickBreak,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
