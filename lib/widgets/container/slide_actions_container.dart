import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';
import 'package:tap_builder/tap_builder.dart';

class AppMenuItem extends Equatable {
  final IconData? icon;
  final String? label;
  final Color? foreground;
  final Color? background;
  final VoidCallback? onTap;

  const AppMenuItem({
    this.icon,
    this.label,
    this.foreground,
    this.background,
    this.onTap,
  });

  @override
  List<Object?> get props => [icon, label, foreground, background, onTap];
}

class AppSlideActionContainer extends StatefulWidget {
  final Widget child;
  final List<AppMenuItem> leftMenuItems;
  final List<AppMenuItem> rightMenuItems;

  const AppSlideActionContainer({
    super.key,
    required this.child,
    this.leftMenuItems = const [],
    this.rightMenuItems = const [],
  });

  @override
  AppSlideActionContainerState createState() => AppSlideActionContainerState();
}

class AppSlideActionContainerState extends State<AppSlideActionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isLeft = false;
  bool isOpen = false;
  Animation<Offset>? _currentAnimation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leftOffsetRatio =
        widget.leftMenuItems.any((element) => element.label != null)
            ? 0.25
            : 0.125;
    final rightOffsetRatio =
        widget.rightMenuItems.any((element) => element.label != null)
            ? 0.25
            : 0.125;
    final rightAnimation = Tween(
            begin: const Offset(0.0, 0.0),
            end: Offset(-rightOffsetRatio * widget.rightMenuItems.length, 0.0))
        .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    final leftAnimation = Tween(
            begin: const Offset(0.0, 0.0),
            end: Offset(leftOffsetRatio * widget.leftMenuItems.length, 0.0))
        .animate(CurveTween(curve: Curves.decelerate).animate(_controller));
    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        final primaryDelta = data.primaryDelta;
        final contextWidth = context.size?.width;
        if (primaryDelta == null || contextWidth == null) return;

        // we can access context.size here

        // if (!isOpen && _currentAnimation?.status != AnimationStatus.forward && _currentAnimation == null) {
        if (_currentAnimation?.isDismissed ?? true) {
          isLeft = primaryDelta >= 0;
          _currentAnimation = primaryDelta < 0 ? rightAnimation : leftAnimation;
        }

        setState(() {
          if (isLeft && widget.leftMenuItems.isNotEmpty) {
            _controller.value += primaryDelta / contextWidth;
          } else if (!isLeft && widget.rightMenuItems.isNotEmpty) {
            _controller.value -= primaryDelta / contextWidth;
          }
        });
      },
      onHorizontalDragEnd: (data) {
        final primaryVelocity = data.primaryVelocity;
        if (primaryVelocity == null) return;
        if (primaryVelocity > 2500) {
          _controller.animateTo(.0);
          isOpen = false;
          _currentAnimation = null;
        } else if (_controller.value >= .5 || primaryVelocity < -2500) {
          _controller.animateTo(1.0);
          isOpen = true;
        } else {
          _controller.animateTo(.0);
          isOpen = false;
          _currentAnimation = null;
        }
      },
      onHorizontalDragCancel: () {
        _currentAnimation = null;
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          left: .0,
                          top: .0,
                          bottom: .0,
                          width:
                              constraint.maxWidth * leftAnimation.value.dx * 1,
                          child: Container(
                            color: Colors.black26,
                            child: Row(
                              children: widget.leftMenuItems.map((data) {
                                return Expanded(
                                  child: AppSliderMenuItem(
                                    label: data.label,
                                    icon: data.icon,
                                    foreground: data.foreground,
                                    background: data.background,
                                    onTap: data.onTap,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth *
                              rightAnimation.value.dx *
                              -1,
                          child: Container(
                            color: Colors.black26,
                            child: Row(
                              children: widget.rightMenuItems.map((data) {
                                return Expanded(
                                  child: AppSliderMenuItem(
                                    label: data.label,
                                    icon: data.icon,
                                    foreground: data.foreground,
                                    background: data.background,
                                    onTap: data.onTap,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SlideTransition(
              position: _currentAnimation ?? leftAnimation,
              child: widget.child),
        ],
      ),
    );
  }
}

class AppSliderMenuItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? foreground;
  final Color? background;
  final String? label;
  final IconData? icon;

  const AppSliderMenuItem({
    super.key,
    this.onTap,
    this.foreground,
    this.background,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final foregroundColorSet =
        AppWidgetStateColorSet(inactive: foreground, hovered: foreground);
    final backgroundColorSet =
        AppWidgetStateColorSet(inactive: background, hovered: background);
    return TapBuilder(
        onTap: onTap,
        builder: (context, state, hasFocus) {
          switch (state) {
            case TapState.inactive:
              return Semantics(
                enabled: true,
                selected: false,
                child: AppSliderMenuItemLayout.inactive(
                    label: label,
                    icon: icon,
                    foreground: foregroundColorSet,
                    background: backgroundColorSet,
                    state: AppWidgetState.inactive),
              );
            case TapState.disabled:
              return AppSliderMenuItemLayout.hovered(
                  label: label,
                  icon: icon,
                  foreground: foregroundColorSet,
                  background: backgroundColorSet,
                  state: AppWidgetState.hovered);
            case TapState.hover:
              return AppSliderMenuItemLayout.pressed(
                  label: label,
                  icon: icon,
                  foreground: foregroundColorSet,
                  background: backgroundColorSet,
                  state: AppWidgetState.pressed);

            case TapState.pressed:
              return AppSliderMenuItemLayout.disabled(
                  label: label,
                  icon: icon,
                  foreground: foregroundColorSet,
                  background: backgroundColorSet,
                  state: AppWidgetState.disabled);
          }
        });
  }
}

class AppSliderMenuItemLayout extends StatelessWidget {
  final AppWidgetStateColorSet foreground;
  final AppWidgetStateColorSet background;
  final AppWidgetState _state;
  final String? label;
  final IconData? icon;

  const AppSliderMenuItemLayout.inactive({
    super.key,
    this.foreground = const AppWidgetStateColorSet(),
    this.background = const AppWidgetStateColorSet(),
    this.label,
    this.icon,
    required AppWidgetState state,
  }) : _state = AppWidgetState.inactive;

  const AppSliderMenuItemLayout.pressed({
    super.key,
    this.foreground = const AppWidgetStateColorSet(),
    this.background = const AppWidgetStateColorSet(),
    this.label,
    this.icon,
    required AppWidgetState state,
  }) : _state = AppWidgetState.pressed;

  const AppSliderMenuItemLayout.hovered({
    super.key,
    this.foreground = const AppWidgetStateColorSet(),
    this.background = const AppWidgetStateColorSet(),
    this.label,
    this.icon,
    required AppWidgetState state,
  }) : _state = AppWidgetState.hovered;

  const AppSliderMenuItemLayout.disabled({
    super.key,
    this.foreground = const AppWidgetStateColorSet(),
    this.background = const AppWidgetStateColorSet(),
    this.label,
    this.icon,
    required AppWidgetState state,
  }) : _state = AppWidgetState.disabled;

  @override
  Widget build(BuildContext context) {
    final iconData = icon;
    final label = this.label;

    final foregroundColor = () {
      final defaultSet = AppWidgetStateColorSet(
        inactive: Colors.amber,
        hovered: Colors.amber.withOpacity(0.6),
        pressed: Colors.amber,
        disabled: Colors.amber,
      );
      return foreground.resolve(_state) ?? defaultSet.resolve(_state);
    }();

    final backgroundColor = () {
      final defaultSet = AppWidgetStateColorSet(
        inactive: Theme.of(context).colorScheme.primary,
        hovered: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        pressed: Theme.of(context).colorScheme.primary.withOpacity(0),
        disabled: Theme.of(context).colorScheme.primary,
      );
      return background.resolve(_state) ?? defaultSet.resolve(_state);
    }();

    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              color: foregroundColor,
            ),
          if (label != null)
            FittedBox(
              fit: BoxFit.fitHeight,
              child: AppText.labelSmall(
                label,
                color: foregroundColor,
              ),
            ),
        ],
      ),
    );
  }
}
