import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedMeter extends StatefulWidget {
  final double value; // Current value for the meter (0.0 - 1.0)
  final double size;
  final Widget Function(BuildContext context, double value) centerBuilder;
  final Widget Function(BuildContext context, double value) bottomBuilder;
  final List<double> markers;

  const AnimatedMeter({
    Key? key,
    required this.value,
    this.size = 200,
    this.markers = const [],
    required this.centerBuilder,
    required this.bottomBuilder,
  }) : super(key: key);

  @override
  State<AnimatedMeter> createState() => _AnimatedMeterState();
}

class _AnimatedMeterState extends State<AnimatedMeter>
    with TickerProviderStateMixin {
  double _value = 0;
  double _max = 100;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _max = widget.markers.isEmpty ? 100 : widget.markers.last;
    _value = widget.value / _max;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: _value),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) => SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: MeterPainter(
                context,
                value: value,
                markers: widget.markers.map((e) => '$e').toList(),
              ),
              size: Size.square(widget.size), // Adjust size as needed
            ),
            widget.centerBuilder(context, widget.value),
            Align(
              alignment: Alignment.bottomCenter,
              child: widget.bottomBuilder(context, value),
            )
          ],
        ),
      ),
    );
  }
}

class MeterPainter extends CustomPainter {
  final double value;
  final BuildContext context;
  final List<String> markers;
  MeterPainter(
    this.context, {
    required this.value,
    this.markers = const [],
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const desiredFillRatio = 0.75;
    const offsetAngle = math.pi / 4;

    const sweepAngle = 2 * math.pi * desiredFillRatio;

    final backgroundColor = Theme.of(context).colorScheme.primaryContainer;
    const backgroundSweepAngle = 2 * math.pi * desiredFillRatio;

    // Background painting
    final backgroundArcPaint = Paint()
      ..color = backgroundColor.withOpacity(0.1)
      ..strokeWidth = 40.0
      // ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 16),
        math.pi - offsetAngle, 2 * math.pi, false, backgroundArcPaint);

    // Background painting 2
    final backgroundArcPaint2 = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.pi - offsetAngle,
        backgroundSweepAngle,
        false,
        backgroundArcPaint2);

    // Indicator progress painting
    final indicatorColor = backgroundColor;
    final indicatorEndColor = Theme.of(context).colorScheme.primary;
    final indicatorSweepAngle = 2 * math.pi * desiredFillRatio * value;

    final indicatorArcPaint = Paint()
      // ..color = indicatorColor
      ..shader = LinearGradient(
        colors: [
          indicatorColor.withOpacity(0.2),
          indicatorEndColor.withOpacity(0.2)
        ],
        stops: [0.0, value],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 40.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 16),
        math.pi - offsetAngle, indicatorSweepAngle, false, indicatorArcPaint);

    // Indicator progress painting
    final indicatorArcPaint2 = Paint()
      // ..color = indicatorColor
      ..shader = LinearGradient(
        colors: [indicatorColor, indicatorEndColor],
        stops: [0.0, value],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        math.pi - offsetAngle, indicatorSweepAngle, false, indicatorArcPaint2);

    // Calculate marker positions and painting
    const markerColor = Colors.white;
    final numMarkers = markers.length;
    const markerRadius = 3.0; // Adjust marker size as needed
    final Paint markerPaint = Paint()
      ..color = markerColor
      ..style = PaintingStyle.fill;
    final markerAngleStep = sweepAngle / (numMarkers - 1);
    for (int i = 0; i < numMarkers; i++) {
      final angle = math.pi - offsetAngle + i * markerAngleStep;
      final markerX = center.dx + radius * math.cos(angle);
      final markerY = center.dy + radius * math.sin(angle);
      canvas.drawCircle(Offset(markerX, markerY), markerRadius, markerPaint);

      // Calculate text position and draw text
      final markerTextRadius = radius - 15;
      final textPainter = TextPainter(
        text: TextSpan(
          text: markers[i],
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: double.infinity);
      final markerTextX = center.dx + markerTextRadius * math.cos(angle);
      final markerTextY = center.dy + markerTextRadius * math.sin(angle);
      final textOffset = Offset(markerTextX - textPainter.width / 2,
          markerTextY - textPainter.height / 2);
      textPainter.paint(canvas, textOffset);
    }

    // ... rest of the painting logic (needle, etc.) ...
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
