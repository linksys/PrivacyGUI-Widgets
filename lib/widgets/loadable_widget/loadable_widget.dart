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

abstract class AppLoadableWidgetController {
  void showSpinner();
  void hideSpinner();
}

class AppLoadableWidget extends StatefulWidget {
  final LoadableWidgetType type;
  final Size? spinnerSize;
  final String? semanticsLabel;
  final bool showSpinnerWhenTap;
  // Button
  final String? title;
  final IconData? icon;
  final Future Function(AppLoadableWidgetController controller)? onTap;
  final Size? buttonSize;
  final EdgeInsets? padding;
  final Color? color;
  // Switch
  final bool? showIcon;
  final bool? value;
  final Future Function(AppLoadableWidgetController controller, dynamic)?
      onChanged;
  final Icon? checkedIcon;
  final Icon? uncheckIcon;

  const AppLoadableWidget({
    super.key,
    required this.type,
    this.spinnerSize,
    this.semanticsLabel,
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
    this.showSpinnerWhenTap = true,
  });

  factory AppLoadableWidget.elevatedButton({
    Key? key,
    required String title,
    Size? spinnerSize,
    String? semanticsLabel,
    IconData? icon,
    Future Function(AppLoadableWidgetController controller)? onTap,
    Size? buttonSize,
    bool showSpinnerWhenTap = true,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.elevatedButton,
        title: title,
        spinnerSize: spinnerSize,
        semanticsLabel: semanticsLabel,
        icon: icon,
        onTap: onTap,
        buttonSize: buttonSize,
        showSpinnerWhenTap: showSpinnerWhenTap,
      );

  factory AppLoadableWidget.filledButton({
    Key? key,
    required String title,
    Size? spinnerSize,
    String? semanticsLabel,
    IconData? icon,
    Future Function(AppLoadableWidgetController controller)? onTap,
    Size? buttonSize,
    bool showSpinnerWhenTap = true,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.filledButton,
        title: title,
        spinnerSize: spinnerSize,
        semanticsLabel: semanticsLabel,
        icon: icon,
        onTap: onTap,
        buttonSize: buttonSize,
        showSpinnerWhenTap: showSpinnerWhenTap,
      );

  factory AppLoadableWidget.outlineButton({
    Key? key,
    required String title,
    Size? spinnerSize,
    String? semanticsLabel,
    IconData? icon,
    Future Function(AppLoadableWidgetController controller)? onTap,
    Color? color,
    Size? buttonSize,
    bool showSpinnerWhenTap = true,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.outlineButton,
        title: title,
        spinnerSize: spinnerSize,
        semanticsLabel: semanticsLabel,
        icon: icon,
        onTap: onTap,
        color: color,
        buttonSize: buttonSize,
        showSpinnerWhenTap: showSpinnerWhenTap,
      );

  factory AppLoadableWidget.textButton({
    Key? key,
    required String title,
    Size? spinnerSize,
    String? semanticsLabel,
    IconData? icon,
    Future Function(AppLoadableWidgetController controller)? onTap,
    Color? color,
    Size? buttonSize,
    EdgeInsets? padding,
    bool showSpinnerWhenTap = true,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.textButton,
        title: title,
        spinnerSize: spinnerSize,
        semanticsLabel: semanticsLabel,
        icon: icon,
        onTap: onTap,
        color: color,
        buttonSize: buttonSize,
        padding: padding,
        showSpinnerWhenTap: showSpinnerWhenTap,
      );

  factory AppLoadableWidget.appSwitch({
    Key? key,
    required bool value,
    Size? spinnerSize,
    String? semanticsLabel,
    IconData? icon,
    Future Function(AppLoadableWidgetController controller, dynamic)? onChanged,
    bool? showIcon,
    Icon? checkedIcon,
    Icon? uncheckIcon,
    bool showSpinnerWhenTap = true,
  }) =>
      AppLoadableWidget(
        key: key,
        type: LoadableWidgetType.appSwitch,
        spinnerSize: spinnerSize,
        semanticsLabel: semanticsLabel,
        value: value,
        icon: icon,
        onChanged: onChanged,
        showIcon: showIcon,
        checkedIcon: checkedIcon,
        uncheckIcon: uncheckIcon,
        showSpinnerWhenTap: showSpinnerWhenTap,
      );

  @override
  State<AppLoadableWidget> createState() => _AppLoadableWidgetState();
}

class _AppLoadableWidgetState extends State<AppLoadableWidget>
    implements AppLoadableWidgetController {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SizedBox(
            height: widget.spinnerSize?.height,
            width: widget.spinnerSize?.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                semanticsLabel: '${widget.semanticsLabel} spinner',
              ),
            ),
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
                semanticLabel: '${widget.semanticsLabel} switch',
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
    if (widget.showSpinnerWhenTap) {
      showSpinner();
    }
    await widget.onTap?.call(this);

    hideSpinner();
  }

  Future<bool> _processOnChanged(bool value) async {
    if (widget.showSpinnerWhenTap) {
      showSpinner();
    }

    await widget.onChanged?.call(this, value);

    hideSpinner();
    return value;
  }

  @override
  void hideSpinner() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showSpinner() {
    setState(() {
      _isLoading = true;
    });
  }
}
