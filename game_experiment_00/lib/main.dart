import 'dart:developer';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

enum AnimationStep {
  idle,
  left,
  right,
  attack,
}

class MyGame extends FlameGame with SingleGameInstance, KeyboardEvents {
  late Sprite player;
  Vector2 playerPosition = Vector2(100, 100);
  Vector2 updatedPosition = Vector2(100, 100);
  AnimationStep step = AnimationStep.idle;

  AnimationStep updatedStep = AnimationStep.idle;

  late SpriteAnimation idle;
  late SpriteAnimation left;
  late SpriteAnimation right;
  late SpriteAnimation attack;

  int speed = 4;

  MyGame() {
    // a = SpriteAnimation.spriteList(sprites, stepTime: stepTime)
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Colors.black;
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isArrowLeftPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    if (keysPressed.isEmpty) {
      updatedStep = AnimationStep.idle;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      updatedStep = AnimationStep.attack;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      updatedPosition.x += speed;
      updatedStep = AnimationStep.right;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      updatedPosition.x -= speed;
      updatedStep = AnimationStep.left;
    }
    return KeyEventResult.ignored;
  }

  @override
  Future<void>? onLoad() async {
    final playerImage = await images.load('Pink_Monster_Walk_6.png');

    right = await SpriteAnimation.load(
      'Pink_Monster_Walk_6.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(32, 32),
        stepTime: 0.1,
      ),
    );

    left = await SpriteAnimation.load(
      'Pink_Monster_Walk_Left_6.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(32, 32),
        stepTime: 0.1,
      ),
    );

    idle = await SpriteAnimation.load(
      'Pink_Monster_Idle_4.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(32, 32),
        stepTime: 0.1,
      ),
    );
    attack = await SpriteAnimation.load(
      'Pink_Monster_Attack2_6.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(32, 32),
        stepTime: 0.1,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    // player.render(canvas);

    switch (step) {
      case AnimationStep.idle:
        idle.getSprite().render(
              canvas,
              position: playerPosition,
              size: Vector2(100, 100),
            );
        break;
      case AnimationStep.left:
        left.getSprite().render(
              canvas,
              position: playerPosition,
              size: Vector2(100, 100),
            );
        break;
      case AnimationStep.right:
        right.getSprite().render(
              canvas,
              position: playerPosition,
              size: Vector2(100, 100),
            );
        break;
      case AnimationStep.attack:
        attack.getSprite().render(
              canvas,
              position: playerPosition,
              size: Vector2(100, 100),
            );
        break;
      default:
    }
  }

  @override
  void update(double dt) {
    idle.update(dt);
    left.update(dt);
    right.update(dt);
    attack.update(dt);
    playerPosition = updatedPosition;
    step = updatedStep;
    // switch (step) {
    //   case value:

    //     break;
    //   default:
    // }
  }
}
