import 'package:flutter/material.dart';

enum AppProgressBarStyle {
  linear,
  circular,
  ;
}

class AppProgressBar extends StatefulWidget {
  final AppProgressBarStyle style;
  final bool repeat;
  final Duration duration;
  final double? stroke;
  final void Function(double)? callback;
  final Color? color;
  final Color? background;

  const AppProgressBar({
    Key? key,
    this.style = AppProgressBarStyle.linear,
    this.repeat = true,
    this.duration = const Duration(seconds: 2),
    this.stroke,
    this.color,
    this.background,
    this.callback,
  }) : super(key: key);

  @override
  State<AppProgressBar> createState() => _AppProgressBarState();
}

class _AppProgressBarState extends State<AppProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.addListener(() {
      setState(() {});
      widget.callback?.call(_controller.value);
    });
    if (widget.repeat) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.style == AppProgressBarStyle.circular) {
      return CircularProgressIndicator(
        value: _controller.value,
        color: widget.color,
        backgroundColor:
            widget.background ?? Theme.of(context).colorScheme.inversePrimary,
        strokeWidth: widget.stroke ?? 4.0,
      );
    }
    return LinearProgressIndicator(
      value: _controller.value,
      color: widget.color,
      backgroundColor:
          widget.background ?? Theme.of(context).colorScheme.inversePrimary,
      minHeight: widget.stroke,
    );
  }
}
