import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';

class AppSwitchTriggerTile extends StatefulWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? description;
  final bool value;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final bool showSwitchIcon;
  final Future Function(bool)? event;
  final void Function(bool)? onChanged;
  final bool toggleInCenter;

  const AppSwitchTriggerTile({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.decoration,
    this.padding,
    this.showSwitchIcon = false,
    required this.value,
    this.event,
    this.onChanged,
    this.toggleInCenter = false,
  });

  @override
  State<AppSwitchTriggerTile> createState() => _AppSwitchTriggerTileState();
}

class _AppSwitchTriggerTileState extends State<AppSwitchTriggerTile> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      padding: widget.padding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.title,
                          if (widget.subtitle != null) widget.subtitle!,
                        ],
                      ),
                    ),
                    if (!widget.toggleInCenter) _buildToggle(),
                  ],
                ),
                if (widget.description != null) ...[
                  const AppGap.regular(),
                  widget.description!
                ],
              ],
            ),
          ),
          if (widget.toggleInCenter) ...[
            const AppGap.regular(),
            _buildToggle()
          ],
        ],
      ),
    );
  }

  Future<bool> _process(bool value) async {
    setState(() {
      _isLoading = true;
    });

    await widget.event?.call(value);

    setState(() {
      _isLoading = false;
    });
    return value;
  }

  Widget _buildToggle() {
    return _isLoading
        ? const CircularProgressIndicator()
        : AppSwitch(
            value: widget.value,
            showIcon: widget.showSwitchIcon,
            onChanged: (value) {
              _process(value).then((value) {
                widget.onChanged?.call(value);
              });
            },
          );
  }
}
