import 'package:flutter/material.dart';

class BreathDot extends StatefulWidget {
  final Duration
      breathSpeed; // Controls the speed of the animation (lower is faster)
  final Color lightColor; // Color of the breathing light
  final Color? borderColor; // Color of the center dot
  final double size;
  final double dotSize;
  final bool animated;

  const BreathDot({
    Key? key,
    required this.breathSpeed,
    required this.lightColor,
    this.borderColor,
    this.size = 24,
    this.dotSize = 20,
    this.animated = true,
  }) : super(key: key);

  @override
  State<BreathDot> createState() => _BreathDotState();
}

class _BreathDotState extends State<BreathDot> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.breathSpeed);

  late final Animation<double> _opacityAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
        ..addListener(() => setState(() {})); // Rebuild on animation changes

  @override
  void initState() {
    super.initState();
    _controller.repeat(reverse: true); // Continuously animate
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Container(
        width: widget.size, // Adjust size as needed
        height: widget.size, // Adjust size as needed

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.borderColor ?? Colors.white,
          ),
        ),
        child: Center(
          child: Container(
            width: widget.dotSize, // Adjust size as needed
            height: widget.dotSize, // Adjust size as needed

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.lightColor
                  .withOpacity(widget.animated ? _opacityAnimation.value : 1),
            ),
          ),
        ),
      ),
    );
  }
}
