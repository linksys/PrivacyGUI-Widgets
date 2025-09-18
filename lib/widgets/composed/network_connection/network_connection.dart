import 'package:flutter/material.dart';

/// Enum representing the different states of network connection.
enum ConnectionStatus {
  noPortConnected,
  noWANConnection,
  noInternetConnection,
  internetConnected,
}

/// A widget that visualizes the network connection status from a device to the internet.
class NetworkConnectionFlow extends StatefulWidget {
  /// The current connection status to display.
  final ConnectionStatus status;

  /// The image provider for the router icon.
  final ImageProvider? routerImageProvider;

  const NetworkConnectionFlow({
    super.key,
    required this.status,
    this.routerImageProvider,
  });

  @override
  State<NetworkConnectionFlow> createState() => _NetworkConnectionFlowState();
}

class _NetworkConnectionFlowState extends State<NetworkConnectionFlow>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final Color activeColor = colors.primary;
    final Color inactiveColor = colors.outline;
    final Color errorColor = colors.error;

    Color deviceColor = inactiveColor;
    Color routerColor = inactiveColor;
    Color internetColor = inactiveColor;
    Color deviceToRouterColor = inactiveColor;
    Color routerToInternetColor = inactiveColor;
    bool deviceToRouterDashed = true;
    bool routerToInternetDashed = true;
    bool deviceToRouterFlow = false;
    bool routerToInternetFlow = false;

    switch (widget.status) {
      case ConnectionStatus.noPortConnected:
        deviceColor = activeColor;
        routerColor = activeColor;
        deviceToRouterColor = activeColor;
        deviceToRouterDashed = false;
        deviceToRouterFlow = true;
        routerToInternetColor = inactiveColor;
        break;
      case ConnectionStatus.noWANConnection:
        deviceColor = activeColor;
        routerColor = activeColor;
        deviceToRouterColor = activeColor;
        deviceToRouterDashed = false;
        deviceToRouterFlow = true;
        routerToInternetColor = activeColor;
        routerToInternetDashed = false;
        routerToInternetFlow = true;
        internetColor = inactiveColor;
        break;
      case ConnectionStatus.noInternetConnection:
        deviceColor = activeColor;
        routerColor = activeColor;
        deviceToRouterColor = activeColor;
        deviceToRouterDashed = false;
        deviceToRouterFlow = true;
        routerToInternetColor = activeColor;
        routerToInternetDashed = false;
        routerToInternetFlow = true;
        internetColor = inactiveColor;
        break;
      case ConnectionStatus.internetConnected:
        deviceColor = activeColor;
        routerColor = activeColor;
        internetColor = activeColor;
        deviceToRouterColor = activeColor;
        deviceToRouterDashed = false;
        deviceToRouterFlow = true;
        routerToInternetColor = activeColor;
        routerToInternetDashed = false;
        routerToInternetFlow = true;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.devices, size: 40, color: deviceColor),
        const SizedBox(width: 8),
        CustomPaint(
          size: const Size(55, 20),
          painter: _ConnectionPathPainter(
            animation: _controller,
            color: deviceToRouterColor,
            isDashed: deviceToRouterDashed,
            flow: deviceToRouterFlow,
          ),
        ),
        const SizedBox(width: 8),
        widget.routerImageProvider != null
            ? Image(image: widget.routerImageProvider!, width: 64, height: 64)
            : Icon(Icons.router, size: 40, color: routerColor),
        if (widget.status == ConnectionStatus.noPortConnected)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.close, size: 24, color: errorColor),
          ),
        const SizedBox(width: 8),
        CustomPaint(
          size: const Size(55, 20),
          painter: _ConnectionPathPainter(
            animation: _controller,
            color: routerToInternetColor,
            isDashed: routerToInternetDashed,
            flow: routerToInternetFlow,
          ),
        ),
        if (widget.status == ConnectionStatus.noWANConnection)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.close, size: 24, color: errorColor),
          ),
        const SizedBox(width: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.public, size: 40, color: internetColor),
            if (widget.status == ConnectionStatus.noInternetConnection)
              Icon(Icons.close, size: 24, color: errorColor),
          ],
        ),
      ],
    );
  }
}

class _ConnectionPathPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final bool isDashed;
  final bool flow;

  _ConnectionPathPainter({
    required this.animation,
    required this.color,
    this.isDashed = false,
    this.flow = false,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    if (isDashed) {
      final dashPath = Path();
      const double dashWidth = 4.0;
      const double dashSpace = 4.0;
      double distance = 0.0;
      while (distance < size.width) {
        dashPath.moveTo(distance, size.height / 2);
        dashPath.lineTo(distance + dashWidth, size.height / 2);
        distance += dashWidth + dashSpace;
      }
      canvas.drawPath(dashPath, paint);
    } else {
      canvas.drawPath(path, paint);
    }

    if (flow) {
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final double progress = animation.value;
      final double dotOffset = size.width * progress;

      // Draw multiple dots for a continuous flow effect
      for (int i = 0; i < 3; i++) {
        final offset = (dotOffset + i * size.width / 3) % size.width;
        canvas.drawCircle(Offset(offset, size.height / 2), 3, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConnectionPathPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.isDashed != isDashed ||
        oldDelegate.flow != flow;
  }
}
