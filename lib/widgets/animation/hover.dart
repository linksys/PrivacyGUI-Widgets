import 'package:flutter/widgets.dart';

class Hover extends StatefulWidget {
  final Widget child;
  final Offset begin;
  final Offset end;
  final Duration duration;
  final bool reverse;

  const Hover({
    super.key,
    this.begin = const Offset(0, 0),
    this.end = const Offset(0, 0.1),
    this.reverse = true,
    this.duration = const Duration(milliseconds: 700),
    required this.child,
  });

  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: widget.reverse);
    _animation = Tween(
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
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
