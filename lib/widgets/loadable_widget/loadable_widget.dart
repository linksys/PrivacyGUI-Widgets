import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/buttons/button.dart';
import 'package:privacygui_widgets/widgets/switch/switch.dart';

enum LoadableWidgetType {
  elevatedButton,
  filledButton,
  // iconButton,
  outlineButton,
  textButton,
  appSwitch,
}

class AppLoadableWidget extends StatefulWidget {
  final LoadableWidgetType type;
  final Size? spinnerSize;
  // Button
  final String? title;
  final IconData? icon;
  final Future Function()? onTap;
  final Size? buttonSize;
  final EdgeInsets? padding;
  final Color? color;
  // Switch
  final bool? showIcon;
  final bool? value;
  final Future Function(dynamic)? onChanged;
  final Icon? checkedIcon;
  final Icon? uncheckIcon;

  const AppLoadableWidget({
    super.key,
    required this.type,
    this.spinnerSize,
    this.title,
    this.icon,
    this.onTap,
    this.buttonSize,
    this.padding,
    this.color,
    this.showIcon,
    this.value,
    this.onChanged,
    this.checkedIcon,
    this.uncheckIcon,
  });

  factory AppLoadableWidget.elevatedButton({
    Key? key,
    required String title,
    Size? spinnerSize,
    IconData? icon,
    Future Function()? onTap,
    Size? buttonSize,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.elevatedButton,
        title: title,
        spinnerSize: spinnerSize,
        icon: icon,
        onTap: onTap,
        buttonSize: buttonSize,
      );

  factory AppLoadableWidget.filledButton({
    Key? key,
    required String title,
    Size? spinnerSize,
    IconData? icon,
    Future Function()? onTap,
    Size? buttonSize,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.filledButton,
        title: title,
        spinnerSize: spinnerSize,
        icon: icon,
        onTap: onTap,
        buttonSize: buttonSize,
      );

  factory AppLoadableWidget.outlineButton({
    Key? key,
    required String title,
    Size? spinnerSize,
    IconData? icon,
    Future Function()? onTap,
    Color? color,
    Size? buttonSize,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.outlineButton,
        title: title,
        spinnerSize: spinnerSize,
        icon: icon,
        onTap: onTap,
        color: color,
        buttonSize: buttonSize,
      );

  factory AppLoadableWidget.textButton({
    Key? key,
    required String title,
    Size? spinnerSize,
    IconData? icon,
    Future Function()? onTap,
    Color? color,
    Size? buttonSize,
    EdgeInsets? padding,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.textButton,
        title: title,
        spinnerSize: spinnerSize,
        icon: icon,
        onTap: onTap,
        color: color,
        buttonSize: buttonSize,
        padding: padding,
      );

  factory AppLoadableWidget.appSwitch({
    Key? key,
    required bool value,
    Size? spinnerSize,
    IconData? icon,
    Future Function(dynamic)? onChanged,
    bool? showIcon,
    Icon? checkedIcon,
    Icon? uncheckIcon,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.appSwitch,
        spinnerSize: spinnerSize,
        value: value,
        icon: icon,
        onChanged: onChanged,
        showIcon: showIcon,
        checkedIcon: checkedIcon,
        uncheckIcon: uncheckIcon,
      );

  @override
  State<AppLoadableWidget> createState() => _AppLoadableWidgetState();
}

class _AppLoadableWidgetState extends State<AppLoadableWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SizedBox(
            height: widget.spinnerSize?.height,
            width: widget.spinnerSize?.width,
            child: const CircularProgressIndicator(),
          )
        : switch (widget.type) {
            LoadableWidgetType.elevatedButton => AppElevatedButton(
                key: widget.key,
                widget.title ?? '',
                icon: widget.icon,
                size: widget.buttonSize,
                onTap: widget.onTap != null
                    ? () {
                        _processOnTap();
                      }
                    : null,
              ),
            LoadableWidgetType.filledButton => AppFilledButton(
                key: widget.key,
                widget.title ?? '',
                icon: widget.icon,
                size: widget.buttonSize,
                onTap: widget.onTap != null
                    ? () {
                        _processOnTap();
                      }
                    : null,
              ),
            LoadableWidgetType.outlineButton => AppOutlinedButton(
                key: widget.key,
                widget.title ?? '',
                icon: widget.icon,
                size: widget.buttonSize,
                color: widget.color,
                onTap: widget.onTap != null
                    ? () {
                        _processOnTap();
                      }
                    : null,
              ),
            LoadableWidgetType.textButton => AppTextButton(
                key: widget.key,
                widget.title ?? '',
                icon: widget.icon,
                size: widget.buttonSize,
                color: widget.color,
                padding: widget.padding,
                onTap: widget.onTap != null
                    ? () {
                        _processOnTap();
                      }
                    : null,
              ),
            LoadableWidgetType.appSwitch => AppSwitch(
                key: widget.key,
                value: widget.value ?? false,
                showIcon: widget.showIcon ?? false,
                checkedIcon: widget.checkedIcon,
                uncheckIcon: widget.uncheckIcon,
                onChanged: widget.onChanged != null
                    ? (value) {
                        _processOnChanged(value);
                      }
                    : null,
              ),
            _ => const AppTextButton('NOT IMPLEMENTED TYPE'),
          };
  }

  Future<void> _processOnTap() async {
    setState(() {
      _isLoading = true;
    });

    await widget.onTap?.call();

    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> _processOnChanged(bool value) async {
    setState(() {
      _isLoading = true;
    });

    await widget.onChanged?.call(value);

    setState(() {
      _isLoading = false;
    });
    return value;
  }
}
