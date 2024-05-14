import 'package:flutter/material.dart';

class Scale extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool reverse;
  final double begin;
  final double end;

  const Scale({
    super.key,
    required this.child,
    this.reverse = false,
    this.begin = 1,
    this.end = 2,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<Scale> createState() => _ScaleState();
}

class _ScaleState extends State<Scale> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: widget.reverse);
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
