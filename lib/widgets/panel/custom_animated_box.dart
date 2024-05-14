import 'package:flutter/material.dart';

class CustomAnimatedBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget child;
  final bool? selectable;

  const CustomAnimatedBox({
    Key? key,
    required this.value,
    this.selectable = false,
    required this.onChanged,
    required this.child,
  }) : super(key: key);

  @override
  State<CustomAnimatedBox> createState() => _CustomAnimatedBoxState();
}

class _CustomAnimatedBoxState extends State<CustomAnimatedBox> {
  late final Duration animationDuration = const Duration(milliseconds: 200);
  double _sizeFactor = 1;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _sizeFactor = 0.95;
        });
      },
      onExit: (event) {
        setState(() {
          _sizeFactor = 1;
        });
      },
      child: GestureDetector(
        onTap: () => widget.onChanged(!widget.value),
        child: AnimatedFractionallySizedBox(
          duration: animationDuration,
          widthFactor: _sizeFactor,
          heightFactor: _sizeFactor,
          child: Stack(
            children: [
              Positioned.fill(child: widget.child),
              Align(
                alignment: Alignment.topRight,
                child: AnimatedContainer(
                  duration: animationDuration,
                  curve: Curves.easeInOut,
                  decoration: (widget.selectable ?? false)
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 2,
                          ),
                        )
                      : null,
                  width: 24,
                  height: 24,
                  child: widget.value
                      ? Icon(
                          Icons.check,
                          size: 16,
                        )
                      : Center(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
