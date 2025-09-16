import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';

class ShimmerCard extends StatefulWidget {
  final bool isLoading;
  final Widget? child;
  final Widget? skeleton; // New property for explicit skeleton
  final Color? baseColor;
  final Color? highlightColor; // Renamed shimmerColor to highlightColor for clarity

  const ShimmerCard({
    Key? key,
    this.isLoading = true,
    this.child,
    this.skeleton, // New property
    this.baseColor,
    this.highlightColor,
  }) : super(key: key);

  @override
  State<ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<ShimmerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child ?? const SizedBox.shrink();
    }

    final baseColor = widget.baseColor ??
        Theme.of(context).colorScheme.surfaceVariant.withAlpha(78);
    final highlightColor = widget.highlightColor ??
        Theme.of(context).colorScheme.primary.withAlpha(128);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(slidePercent: _animation.value),
            ).createShader(bounds);
          },
          child: widget.skeleton ?? _buildDefaultSkeleton(),
        );
      },
    );
  }

  Widget _buildDefaultSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3), // Placeholder color
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const AppGap.medium(),
          Container(
            width: 200,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3), // Placeholder color
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const AppGap.small2(),
          Container(
            width: 150,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3), // Placeholder color
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom gradient transform to make the shimmer slide
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}