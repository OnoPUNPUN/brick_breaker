import 'package:flutter/material.dart';

class Bricks extends StatelessWidget {
  final brickX;
  final brickY;
  final brickHeight;
  final brickWidth;
  final bool brickBreak;

  const Bricks({
    super.key,
    this.brickHeight,
    this.brickWidth,
    this.brickX,
    this.brickY,
    required this.brickBreak,
  });

  @override
  Widget build(BuildContext context) {
    return brickBreak
        ? Container()
        : Container(
            alignment: Alignment(brickX, brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                color: Colors.green,
              ),
            ),
          );
  }
}
