import 'package:flutter/material.dart';
import 'package:skillscan/app/core/values/app_colors.dart';

class ScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;

  ScannerAnimation(
    this.stopped,
    this.width, {
    Key? key,
    required Animation<double> animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final scorePosition = (animation.value * 630);

    Color color1 = AppColors.purple;
    Color color2 = AppColors.purple.withOpacity(0);

    if (animation.status == AnimationStatus.reverse) {
      color1 = color2;
      color2 = AppColors.purple;
    }

    return Positioned(
      bottom: scorePosition,
      child: Opacity(
        opacity: (stopped) ? 0.0 : 1.0,
        child: Container(
          height: 50.0,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [color1, color2],
            ),
          ),
        ),
      ),
    );
  }
}
