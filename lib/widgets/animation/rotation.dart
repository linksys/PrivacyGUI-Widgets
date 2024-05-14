import 'package:flutter/material.dart';

class Rotation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final bool reverse;

  const Rotation({
    super.key,
    required this.child,
    this.begin = 0,
    this.end = 1,
    this.reverse = false,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<Rotation> createState() => _RotationState();
}

class _RotationState extends State<Rotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: widget.reverse);
    _animation = Tween<double>(
      begin: widget.begin,
      end: widget.end,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }
}
