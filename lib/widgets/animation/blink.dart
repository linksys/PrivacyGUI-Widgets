import 'package:flutter/material.dart';

class Blink extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const Blink({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<Blink> createState() => _BlinkState();
}

class _BlinkState extends State<Blink>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
