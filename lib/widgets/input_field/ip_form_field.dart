import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/input_field/input_formatters.dart';

class AppIPFormField extends StatefulWidget {
  const AppIPFormField({
    super.key,
    this.header,
    this.onChanged,
    this.onFocusChanged,
    this.controller,
    this.errorText,
    this.border = const UnderlineInputBorder(),
    this.octet1ReadOnly = false,
    this.octet2ReadOnly = false,
    this.octet3ReadOnly = false,
    this.octet4ReadOnly = false,
    this.acceptEmpty = true,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final Widget? header;
  final String? errorText;
  final InputBorder border;
  final bool octet1ReadOnly;
  final bool octet2ReadOnly;
  final bool octet3ReadOnly;
  final bool octet4ReadOnly;
  final bool acceptEmpty;

  @override
  State<AppIPFormField> createState() => _AppIPFormFieldState();
}

class _AppIPFormFieldState extends State<AppIPFormField> {
  final _octet1Controller = TextEditingController();
  final _octet2Controller = TextEditingController();
  final _octet3Controller = TextEditingController();
  final _octet4Controller = TextEditingController();

  final _octet1Focus = FocusNode();
  final _octet2Focus = FocusNode();
  final _octet3Focus = FocusNode();
  final _octet4Focus = FocusNode();

  @override
  void initState() {
    super.initState();

    _octet1Controller.text = '';
    _octet2Controller.text = '';
    _octet3Controller.text = '';
    _octet4Controller.text = '';

    widget.controller?.addListener(_onTextChanged);
    _octet1Focus.addListener(_onFocusChange);
    _octet2Focus.addListener(_onFocusChange);
    _octet3Focus.addListener(_onFocusChange);
    _octet4Focus.addListener(_onFocusChange);

    _onTextChanged();
  }

  @override
  void dispose() {
    _octet1Focus.removeListener(_onFocusChange);
    _octet2Focus.removeListener(_onFocusChange);
    _octet3Focus.removeListener(_onFocusChange);
    _octet4Focus.removeListener(_onFocusChange);
    _octet1Controller.dispose();
    _octet2Controller.dispose();
    _octet3Controller.dispose();
    _octet4Controller.dispose();
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onFocusChange() {
    widget.onFocusChanged?.call(
      _octet1Focus.hasFocus ||
          _octet2Focus.hasFocus ||
          _octet3Focus.hasFocus ||
          _octet4Focus.hasFocus,
    );
  }

  void _onTextChanged() {
    final controller = widget.controller!;
    final value = controller.text;
    if (value.isNotEmpty) {
      final token = value.split('.');

      if (token.isNotEmpty) {
        _octet1Controller.value = TextEditingValue(
            text: token[0],
            selection: TextSelection.collapsed(offset: token[0].length));
      }
      if (token.length > 1) {
        _octet2Controller.value = TextEditingValue(
            text: token[1],
            selection: TextSelection.collapsed(offset: token[1].length));
      }
      if (token.length > 2) {
        _octet3Controller.value = TextEditingValue(
            text: token[2],
            selection: TextSelection.collapsed(offset: token[2].length));
      }
      if (token.length > 3) {
        _octet4Controller.value = TextEditingValue(
            text: token[3],
            selection: TextSelection.collapsed(offset: token[3].length));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorText = widget.errorText;
    final isError = widget.errorText != null ? true : false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.header != null) ...[
          widget.header!,
          const AppGap.small2(),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildOctetInputForm(
              _octet1Focus,
              _octet2Focus,
              _octet1Controller,
              readOnly: widget.octet1ReadOnly,
              isError: isError,
            ),
            _buildDotWidget(),
            _buildOctetInputForm(
              _octet2Focus,
              _octet3Focus,
              _octet2Controller,
              readOnly: widget.octet2ReadOnly,
              isError: isError,
            ),
            _buildDotWidget(),
            _buildOctetInputForm(
              _octet3Focus,
              _octet4Focus,
              _octet3Controller,
              readOnly: widget.octet3ReadOnly,
              isError: isError,
            ),
            _buildDotWidget(),
            _buildOctetInputForm(
              _octet4Focus,
              _octet4Focus,
              _octet4Controller,
              readOnly: widget.octet4ReadOnly,
              isError: isError,
              isLast: true,
            ),
          ],
        ),
        if (errorText != null) const AppGap.small3(),
        if (errorText != null)
          AppText.bodySmall(
            errorText,
            color: Theme.of(context).colorScheme.error,
            maxLines: 10,
          ),
      ],
    );
  }

  _buildDotWidget() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small2),
        child: AppText.titleLarge(
          '.',
        ),
      );

  _buildOctetInputForm(
    FocusNode focus,
    FocusNode nextFocus,
    TextEditingController controller, {
    bool isLast = false,
    bool readOnly = false,
    bool isError = false,
  }) {
    final border = widget.border.copyWith(
        borderSide: widget.border.borderSide.copyWith(
            color: isError
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onBackground));
    return Expanded(
      child: Opacity(
        opacity: readOnly ? 0.5 : 1.0,
        child: TextFormField(
          controller: controller,
          focusNode: focus,
          decoration: InputDecoration(
            border: border,
            enabledBorder: border,
            focusedBorder: border,
          ),
          readOnly: readOnly,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // allow only  digits
            IPOctetsFormatter(acceptEmpty: widget.acceptEmpty),
            // custom class to format entered data from textField
            LengthLimitingTextInputFormatter(3)
            // restrict user to enter max 16 characters
          ],
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          keyboardType: TextInputType.number,
          textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
          onChanged: (value) {
            if (value.length >= 3) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
            widget.controller?.text = _combineOctets();
            widget.onChanged?.call(_combineOctets());
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(nextFocus);
          },
        ),
      ),
    );
  }

  String _combineOctets() {
    return '${_octet1Controller.text}.${_octet2Controller.text}.${_octet3Controller.text}.${_octet4Controller.text}';
  }
}
