import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linksys_widgets/theme/const/spacing.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';
import 'package:linksys_widgets/widgets/input_field/input_formatters.dart';

class AppIPv6FormField extends StatefulWidget {
  const AppIPv6FormField({
    super.key,
    this.header,
    this.onChanged,
    this.onFocusChanged,
    this.controller,
    this.isError = false,
    this.border = const UnderlineInputBorder(),
    this.octet1ReadOnly = false,
    this.octet2ReadOnly = false,
    this.octet3ReadOnly = false,
    this.octet4ReadOnly = false,
    this.octet5ReadOnly = false,
    this.octet6ReadOnly = false,
    this.octet7ReadOnly = false,
    this.octet8ReadOnly = false,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final Widget? header;
  final bool isError;
  final InputBorder border;
  final bool octet1ReadOnly;
  final bool octet2ReadOnly;
  final bool octet3ReadOnly;
  final bool octet4ReadOnly;
  final bool octet5ReadOnly;
  final bool octet6ReadOnly;
  final bool octet7ReadOnly;
  final bool octet8ReadOnly;

  @override
  State<AppIPv6FormField> createState() => _AppIPv6FormFieldState();
}

class _AppIPv6FormFieldState extends State<AppIPv6FormField> {
  final _octet1Controller = TextEditingController();
  final _octet2Controller = TextEditingController();
  final _octet3Controller = TextEditingController();
  final _octet4Controller = TextEditingController();
  final _octet5Controller = TextEditingController();
  final _octet6Controller = TextEditingController();
  final _octet7Controller = TextEditingController();
  final _octet8Controller = TextEditingController();

  final _octet1Focus = FocusNode();
  final _octet2Focus = FocusNode();
  final _octet3Focus = FocusNode();
  final _octet4Focus = FocusNode();
  final _octet5Focus = FocusNode();
  final _octet6Focus = FocusNode();
  final _octet7Focus = FocusNode();
  final _octet8Focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _octet1Controller.text = '';
    _octet2Controller.text = '';
    _octet3Controller.text = '';
    _octet4Controller.text = '';
    _octet5Controller.text = '';
    _octet6Controller.text = '';
    _octet7Controller.text = '';
    _octet8Controller.text = '';
    widget.controller?.addListener(_onTextChanged);
    _octet1Focus.addListener(_onFocusChange);
    _octet2Focus.addListener(_onFocusChange);
    _octet3Focus.addListener(_onFocusChange);
    _octet4Focus.addListener(_onFocusChange);
    _octet5Focus.addListener(_onFocusChange);
    _octet6Focus.addListener(_onFocusChange);
    _octet7Focus.addListener(_onFocusChange);
    _octet8Focus.addListener(_onFocusChange);

    _onTextChanged();
  }

  @override
  void dispose() {
    _octet1Focus.removeListener(_onFocusChange);
    _octet2Focus.removeListener(_onFocusChange);
    _octet3Focus.removeListener(_onFocusChange);
    _octet4Focus.removeListener(_onFocusChange);
    _octet5Focus.removeListener(_onFocusChange);
    _octet6Focus.removeListener(_onFocusChange);
    _octet7Focus.removeListener(_onFocusChange);
    _octet8Focus.removeListener(_onFocusChange);
    _octet1Controller.dispose();
    _octet2Controller.dispose();
    _octet3Controller.dispose();
    _octet4Controller.dispose();
    _octet5Controller.dispose();
    _octet6Controller.dispose();
    _octet7Controller.dispose();
    _octet8Controller.dispose();
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onFocusChange() {
    widget.onFocusChanged?.call(
      _octet1Focus.hasFocus ||
          _octet2Focus.hasFocus ||
          _octet3Focus.hasFocus ||
          _octet4Focus.hasFocus ||
          _octet5Focus.hasFocus ||
          _octet6Focus.hasFocus ||
          _octet7Focus.hasFocus ||
          _octet8Focus.hasFocus,
    );
  }

  void _onTextChanged() {
    final controller = widget.controller!;
    final value = controller.text;
    if (value.isNotEmpty) {
      final token = value.split(':');
      if (token.length != 8) {
        return;
      }

      _octet1Controller.value = TextEditingValue(
          text: token[0],
          selection: TextSelection.collapsed(offset: token[0].length));
      _octet2Controller.value = TextEditingValue(
          text: token[1],
          selection: TextSelection.collapsed(offset: token[1].length));
      _octet3Controller.value = TextEditingValue(
          text: token[2],
          selection: TextSelection.collapsed(offset: token[2].length));
      _octet4Controller.value = TextEditingValue(
          text: token[3],
          selection: TextSelection.collapsed(offset: token[3].length));
      _octet5Controller.value = TextEditingValue(
          text: token[4],
          selection: TextSelection.collapsed(offset: token[4].length));
      _octet6Controller.value = TextEditingValue(
          text: token[5],
          selection: TextSelection.collapsed(offset: token[5].length));
      _octet7Controller.value = TextEditingValue(
          text: token[6],
          selection: TextSelection.collapsed(offset: token[6].length));
      _octet8Controller.value = TextEditingValue(
          text: token[7],
          selection: TextSelection.collapsed(offset: token[7].length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.header != null) ...[
          widget.header!,
          const AppGap.semiSmall(),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildOctetInputForm(_octet1Focus, _octet2Focus, _octet1Controller,
                readOnly: widget.octet1ReadOnly),
            _buildDotWidget(),
            _buildOctetInputForm(_octet2Focus, _octet3Focus, _octet2Controller,
                readOnly: widget.octet2ReadOnly),
            _buildDotWidget(),
            _buildOctetInputForm(_octet3Focus, _octet4Focus, _octet3Controller,
                readOnly: widget.octet3ReadOnly),
            _buildDotWidget(),
            _buildOctetInputForm(_octet4Focus, _octet5Focus, _octet4Controller,
                readOnly: widget.octet4ReadOnly),
            _buildDotWidget(),
            _buildOctetInputForm(_octet5Focus, _octet6Focus, _octet5Controller,
                readOnly: widget.octet5ReadOnly),
            _buildDotWidget(),
            _buildOctetInputForm(_octet6Focus, _octet7Focus, _octet6Controller,
                readOnly: widget.octet6ReadOnly),
            _buildDotWidget(),
            _buildOctetInputForm(_octet7Focus, _octet8Focus, _octet7Controller,
                readOnly: widget.octet7ReadOnly),
            _buildDotWidget(),
            _buildOctetInputForm(_octet8Focus, _octet8Focus, _octet8Controller,
                readOnly: widget.octet8ReadOnly, isLast: true),
          ],
        ),
      ],
    );
  }

  _buildDotWidget() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.semiSmall),
        child: AppText.titleLarge(
          ':',
        ),
      );

  _buildOctetInputForm(
    FocusNode focus,
    FocusNode nextFocus,
    TextEditingController controller, {
    bool isLast = false,
    bool readOnly = false,
  }) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        focusNode: focus,
        decoration: InputDecoration(border: widget.border),
        readOnly: readOnly,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]')),
          // allow only  digits
          IPv6OctetsFormatter(),
          // custom class to format entered data from textField
          LengthLimitingTextInputFormatter(4)
          // restrict user to enter max 16 characters
        ],
        keyboardType: TextInputType.number,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        onChanged: (value) {
          if (value.length >= 4) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
          widget.controller?.text = _combineOctets();
          widget.onChanged?.call(_combineOctets());
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocus);
        },
      ),
    );
  }

  String _combineOctets() {
    return '${_octet1Controller.text}:${_octet2Controller.text}:${_octet3Controller.text}:${_octet4Controller.text}:${_octet5Controller.text}:${_octet6Controller.text}:${_octet7Controller.text}:${_octet8Controller.text}';
  }
}
