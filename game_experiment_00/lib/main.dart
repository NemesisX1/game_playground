import 'dart:html';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with SingleGameInstance, KeyboardEvents {
  late Sprite player;

  late SpriteAnimation a;

  MyGame() {
    // a = SpriteAnimation.spriteList(sprites, stepTime: stepTime)
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Colors.black;
  }

  @override
  Future<void>? onLoad() async {
    final playerImage = await images.load('Pink_Monster_Attack1_4.png');

    a = SpriteAnimation.fromFrameData(
      playerImage,
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(32, 32),
        stepTime: 0.1,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    // player.render(canvas);
    a.getSprite().render(
          canvas,
          position: Vector2(100, 100),
          size: Vector2(100, 100),
        );
  }

  @override
  void update(double dt) {
    a.update(dt);
  }
}
