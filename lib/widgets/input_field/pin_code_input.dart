import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Defines the visual decoration for a single PIN code input field.
class PinCodeFieldDecoration {
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final double width;
  final double height;
  final Color? fillColor;

  const PinCodeFieldDecoration({
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 5.0,
    this.width = 50.0,
    this.height = 50.0,
    this.fillColor,
  });

  PinCodeFieldDecoration copyWith({
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? width,
    double? height,
    Color? fillColor,
  }) {
    return PinCodeFieldDecoration(
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      width: width ?? this.width,
      height: height ?? this.height,
      fillColor: fillColor ?? this.fillColor,
    );
  }
}

class AppPinCodeInput extends StatefulWidget {
  final int length;
  final String? semanticLabel;
  final String? semanticIdentifier;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<int>? onFocusChanged;
  final ValueChanged<String>? onChanged;
  final bool stayOnLastField;
  final PinCodeFieldDecoration? defaultFieldDecoration;
  final PinCodeFieldDecoration? focusedFieldDecoration;
  final bool autoFocus;

  const AppPinCodeInput({
    Key? key,
    required this.length,
    this.semanticLabel,
    this.semanticIdentifier,
    this.controller,
    this.onSubmitted,
    this.onFocusChanged,
    this.onChanged,
    this.stayOnLastField = false,
    this.defaultFieldDecoration,
    this.focusedFieldDecoration,
    this.autoFocus = false,
  })  : assert(length > 0),
        super(key: key);

  @override
  State<AppPinCodeInput> createState() => _AppPinCodeInputState();
}

class _AppPinCodeInputState extends State<AppPinCodeInput> {
  final defaultFieldDecoration = PinCodeFieldDecoration(
    borderWidth: 1.0,
    borderRadius: 5.0,
    width: 50.0,
    height: 50.0,
  );
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );

    // Request initial focus for the first field if autoFocus is enabled.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.autoFocus) {
        FocusScope.of(context).requestFocus(_focusNodes[0]);
        // Explicitly show keyboard on initial autoFocus
        // SystemChannels.textInput.invokeMethod('TextInput.show');
      }
    });
    widget.controller?.addListener(_onTextChanged);

    for (int i = 0; i < widget.length; i++) {
      _controllers[i].text = '';
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          widget.onFocusChanged?.call(i);
          // Set selection to the end of text when a field gains focus
          // to allow easier modification.
          if (_controllers[i].text.isNotEmpty) {
            _controllers[i].selection = TextSelection.fromPosition(
              TextPosition(offset: _controllers[i].text.length),
            );
          }
        }
        // setState(() {}); // Rebuild to update border colors based on focus
      });
    }
    _onTextChanged();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  /// Determines the index of the field that should currently receive focus.
  /// If there's an empty field, it's the first empty one.
  /// If all fields are filled, it's the last field.
  int _getAutoFocusIndex() {
    int firstEmptyIndex =
        _controllers.indexWhere((element) => element.text.isEmpty);
    if (firstEmptyIndex == -1) {
      // All fields are filled
      return widget.length - 1; // Focus on the last field
    }
    return firstEmptyIndex; // Focus on the first empty field
  }

  void _onTextChanged() {
    final controller = widget.controller;
    final value = controller?.text ?? '';
    if (value.isNotEmpty) {
      for (int i = 0; i < value.length; i++) {
        _controllers[i].value = TextEditingValue(
            text: value[i],
            selection: TextSelection.collapsed(offset: value[i].length));
      }
    } else {
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].value = TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: value.length),
        );
      }
    }
  }

  String _combineValues() {
    return _controllers.map((controller) => controller.text).join('');
  }

  @override
  Widget build(BuildContext context) {
    // Determine the index of the first empty field to control `readOnly` and `IgnorePointer`.
    int firstEmptyIndex =
        _controllers.indexWhere((element) => element.text.isEmpty);
    bool allFieldsFilled = (firstEmptyIndex == -1);
    // If all fields are filled, logically consider the "target" as the last field.
    if (allFieldsFilled) {
      firstEmptyIndex = widget.length;
    }

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Resolve default and focused field decorations, falling back to theme colors if borderColor is null.
    final PinCodeFieldDecoration defaultDecoration =
        widget.defaultFieldDecoration ??
            defaultFieldDecoration.copyWith(
              borderColor: colorScheme.onSurface,
            );

    final PinCodeFieldDecoration focusedDecoration =
        widget.focusedFieldDecoration ??
            defaultFieldDecoration.copyWith(
              borderColor: colorScheme.primary,
            );

    return GestureDetector(
      // Ensure GestureDetector captures all taps within its bounds, even on its children.
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // When the PIN area is tapped, forcefully unfocus any active field
        // then request focus for the logically correct input field.
        FocusManager.instance.primaryFocus?.unfocus();
        int targetIndex = _getAutoFocusIndex();
        FocusScope.of(context).requestFocus(_focusNodes[targetIndex]);
        // Explicitly show keyboard after requesting focus. This ensures keyboard appears on tap.
        // SystemChannels.textInput.invokeMethod('TextInput.show');
      },
      child: KeyboardListener(
        focusNode: FocusNode(), // KeyboardListener requires its own FocusNode
        onKeyEvent: (KeyEvent event) {
          // Handle backspace key press for custom deletion logic.
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            int? currentFocusedIndex;
            for (int i = 0; i < widget.length; i++) {
              if (_focusNodes[i].hasFocus) {
                currentFocusedIndex = i;
                break;
              }
            }

            if (currentFocusedIndex != null) {
              // If current field has text, clear it.
              if (_controllers[currentFocusedIndex].text.isNotEmpty) {
                _controllers[currentFocusedIndex].clear();
              } else if (currentFocusedIndex > 0) {
                // If current field is empty, move focus to the previous field and clear it.
                FocusScope.of(context)
                    .requestFocus(_focusNodes[currentFocusedIndex - 1]);
                _controllers[currentFocusedIndex - 1].clear();
                // No need to call TextInput.show here; keyboard should already be up.
              }
              widget.onChanged?.call(_combineValues());
              // setState(() {}); // Rebuild to reflect changes
            }
          }
        },
        child: Semantics(
          label: widget.semanticLabel,
          identifier: widget.semanticIdentifier,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.length, (index) {
              // Determine field decoration based on current focus state.
              final PinCodeFieldDecoration currentFieldDecoration =
                  _focusNodes[index].hasFocus
                      ? focusedDecoration
                      : defaultDecoration;

              // Determine effective border color based on focus, falling back to theme colors.
              Color effectiveBorderColor;
              if (_focusNodes[index].hasFocus) {
                effectiveBorderColor =
                    focusedDecoration.borderColor ?? colorScheme.primary;
              } else {
                effectiveBorderColor =
                    defaultDecoration.borderColor ?? colorScheme.onSurface;
              }

              return IgnorePointer(
                // Other fields will have their taps captured by the parent GestureDetector.
                child: SizedBox(
                  width: currentFieldDecoration.width,
                  height: currentFieldDecoration.height,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          1), // Allow only one character
                      FilteringTextInputFormatter
                          .digitsOnly, // Allow only digits
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            currentFieldDecoration.borderRadius),
                        borderSide: BorderSide(
                          color: effectiveBorderColor,
                          width: currentFieldDecoration.borderWidth,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            focusedDecoration.borderRadius),
                        borderSide: BorderSide(
                          color: focusedDecoration.borderColor ??
                              colorScheme.primary,
                          width: focusedDecoration.borderWidth,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            currentFieldDecoration.borderRadius),
                        borderSide: BorderSide(
                          color: effectiveBorderColor,
                          width: currentFieldDecoration.borderWidth,
                        ),
                      ),
                      fillColor: currentFieldDecoration.fillColor,
                      filled: currentFieldDecoration.fillColor != null,
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        // If a character is entered
                        if (index < widget.length - 1) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index + 1]);
                          // After requesting focus, explicitly show keyboard
                          // This is crucial for web/mobile browsers that might hide it on focus transfer
                          // SystemChannels.textInput.invokeMethod('TextInput.show'); // <--- CRUCIAL CHANGE HERE
                        } else {
                          // All fields are filled. If not staying on last field, unfocus.
                          if (_controllers
                              .every((element) => element.text.isNotEmpty)) {
                            if (!widget.stayOnLastField) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          }
                        }
                      }
                      widget.controller?.text = _combineValues();
                      widget.onChanged?.call(_combineValues());
                    },
                    onFieldSubmitted: (value) {
                      if (!widget.stayOnLastField &&
                          _controllers
                              .every((element) => element.text.isNotEmpty)) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                      widget.onSubmitted?.call(_combineValues());
                    },
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
