import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipCard extends StatefulWidget {
  static const routeName = "testt";
  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> rotateX;
  Animation<double> rotateY;
  Animation<double> rotateZ;

  @override
  initState() {
    super.initState();

    animationController = new AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    rotateY = new Tween<double>(
      begin: .0,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutBack,
    ));
  }

  void dispose() {
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final icon = Icon(Icons.location_on,
            color: animationController.value >= 3 / 6
                ? Colors.red
                : Theme.of(context).accentColor,
            size: height * 0.4);
        return new Transform(
          transform: new Matrix4.rotationY(rotateY.value * math.pi),
          alignment: Alignment.center,
          child: icon,
        );
      },
    );
  }
}
