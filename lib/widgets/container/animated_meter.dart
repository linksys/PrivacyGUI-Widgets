import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedMeter extends StatefulWidget {
  final double value; // Current value for the meter (0.0 - 1.0)
  final double size;
  final double indicatorPathStrokeWidth;
  final double markerRadius;
  final bool displayIndicatorValues;
  final Widget Function(BuildContext context, double value) centerBuilder;
  final Widget Function(BuildContext context, double value)? bottomBuilder;
  final List<double> markers;

  const AnimatedMeter({
    Key? key,
    required this.value,
    this.size = 200,
    this.markers = const [],
    this.indicatorPathStrokeWidth = 16,
    this.displayIndicatorValues = true,
    this.markerRadius = 4,
    required this.centerBuilder,
    this.bottomBuilder,
  }) : super(key: key);

  const AnimatedMeter.withDefaultMarks({
    Key? key,
    required this.value,
    this.size = 200,
    this.indicatorPathStrokeWidth = 16,
    this.displayIndicatorValues = true,
    this.markerRadius = 4,
    required this.centerBuilder,
    this.bottomBuilder,
  })  : markers = const [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
        super(key: key);

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
  Widget build(BuildContext context) {
    _max = widget.markers.isEmpty ? 100 : widget.markers.last;
    _value = _getIndicatorValue(widget.value, _max, widget.markers);
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: _value > 1 ? 1 : _value),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) => SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              painter: MeterPainter(
                context,
                value: value,
                displayIndicatorValues: widget.displayIndicatorValues,
                indicatorStrokeWidth: widget.indicatorPathStrokeWidth,
                markerRadius: widget.markerRadius,
                markers: widget.markers.map((e) => '$e').toList(),
              ),
              size: Size.square(widget.size), // Adjust size as needed
            ),
            widget.centerBuilder(context, widget.value),
            Align(
              alignment: Alignment.bottomCenter,
              child: widget.bottomBuilder?.call(context, value),
            ),
          ],
        ),
      ),
    );
  }
}

double _getIndicatorValue(double value, double max, List<double> markers) {
  // No need to get value
  if (markers.isEmpty || value >= max) return value / max;
  // Get interval limit
  final intervalLimit = markers.firstWhere((element) => value <= element);
  final intervalLimitIndex = markers.indexOf(intervalLimit);
  if (intervalLimitIndex < 1) return 0;
  // Get interval lower limit
  final intervalLowerLimitIndex = intervalLimitIndex - 1;
  final intervalLowerLimit = markers[intervalLowerLimitIndex];
  // Get indicator value
  double returnValue = 0.0;
  final double intervalOffset = 1 / (markers.length - 1);
  final valueInIntervalOffset =
      (value - intervalLowerLimit) / (intervalLimit - intervalLowerLimit);
  returnValue = intervalLowerLimitIndex * intervalOffset +
      (valueInIntervalOffset * intervalOffset);

  return returnValue;
}

class MeterPainter extends CustomPainter {
  final double value;
  final BuildContext context;
  final List<String> markers;
  final double indicatorStrokeWidth;
  final double markerRadius;
  final bool displayIndicatorValues;

  MeterPainter(
    this.context, {
    required this.value,
    this.indicatorStrokeWidth = 16,
    this.markerRadius = 4,
    this.markers = const [],
    this.displayIndicatorValues = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 20;
    final outsideIndicatorRadius = math.min(size.width, size.height) / 2;
    const desiredFillRatio = 0.8;
    const offsetAngle = (2 * math.pi) / 20 * 3;

    const sweepAngle = 2 * math.pi * desiredFillRatio;

    final backgroundColor = Theme.of(context).colorScheme.primaryContainer;
    const backgroundSweepAngle = 2 * math.pi * desiredFillRatio;

    // Background painting
    final backgroundArcPaint = Paint()
      ..color = backgroundColor.withOpacity(0.1)
      ..strokeWidth = 80.0
      // ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 40),
        math.pi - offsetAngle, 2 * math.pi, false, backgroundArcPaint);

    // Background painting 2
    final backgroundArcPaint2 = Paint()
      ..color = backgroundColor
      ..strokeWidth = indicatorStrokeWidth
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
      ..strokeWidth = 80.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 40),
        math.pi - offsetAngle, indicatorSweepAngle, false, indicatorArcPaint);

    // Indicator progress painting
    final indicatorArcPaint2 = Paint()
      // ..color = indicatorColor
      ..shader = LinearGradient(
        colors: [indicatorColor, indicatorEndColor],
        stops: [0.0, value],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 16.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        math.pi - offsetAngle, indicatorSweepAngle, false, indicatorArcPaint2);

    if (value != 0) {
      // Indicator progress background painting
      final indicatorArcPaint3 = Paint()
        ..color = Colors.white.withOpacity(0.1)
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      // canvas.drawArc(
      //     Rect.fromCircle(center: center, radius: outsideIndicatorRadius),
      //     math.pi - offsetAngle,
      //     2 * math.pi * desiredFillRatio,
      //     false,
      //     indicatorArcPaint3);

      // Indicator progress painting
      const ousideIndicatorlength = 2 * math.pi * 0.333;
      double startAngle = math.pi -
          offsetAngle +
          indicatorSweepAngle -
          (ousideIndicatorlength / 2);
      final indicatorArcPaint4 = Paint()
        // ..color = indicatorEndColor
        ..shader = SweepGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            indicatorColor,
            indicatorEndColor,
            indicatorColor,
            Colors.white.withOpacity(0.1),
          ],
          stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
          startAngle: startAngle,
          endAngle: startAngle + ousideIndicatorlength,
        ).createShader(
            Rect.fromCircle(center: center, radius: outsideIndicatorRadius))
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      // canvas.drawArc(
      //     Rect.fromCircle(center: center, radius: outsideIndicatorRadius),
      //     startAngle,
      //     ousideIndicatorlength,
      //     false,
      //     indicatorArcPaint4);
    }

    // Calculate marker positions and painting
    const markerColor = Colors.white;
    final numMarkers = markers.length;
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
      if (displayIndicatorValues) {
        final markerTextRadius = radius - 24;
        final textPainter = TextPainter(
          text: TextSpan(
            text: markers[i],
            style: Theme.of(context)
                .textTheme
                .bodyMedium
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
    }

    // ... rest of the painting logic (needle, etc.) ...
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
