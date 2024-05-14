import 'package:flutter/services.dart';

class IPv6OctetsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return const TextEditingValue(
          text: '', // final generated credit card number
          selection: TextSelection.collapsed(
              offset: ''.length) // keep the cursor at end
          );
    }
    String enteredData = newValue.text; // get data enter by used in textField
    StringBuffer buffer = StringBuffer();

    final intValue = int.tryParse(enteredData, radix: 16);

    if ((intValue ?? 0x10000) > 0xffff) {
      buffer.clear();
      buffer.write('ffff');
    } else {
      buffer.write(enteredData);
    }
    return TextEditingValue(
        text: buffer.toString(), // final generated credit card number
        selection: TextSelection.collapsed(
            offset: buffer.toString().length) // keep the cursor at end
        );
  }
}

class IPOctetsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return const TextEditingValue(
          text: '0', // final generated credit card number
          selection: TextSelection.collapsed(
              offset: '0'.length) // keep the cursor at end
          );
    }
    String enteredData = newValue.text; // get data enter by used in textField
    StringBuffer buffer = StringBuffer();

    final intValue = int.tryParse(enteredData);
    if ((intValue ?? 256) > 255) {
      buffer.clear();
      buffer.write(0);
    } else {
      buffer.write(intValue);
    }
    return TextEditingValue(
        text: buffer.toString(), // final generated credit card number
        selection: TextSelection.collapsed(
            offset: buffer.toString().length) // keep the cursor at end
        );
  }
}

class MacAddressFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String enteredData = newValue.text; // get data enter by used in textField
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < enteredData.length; i++) {
      // add each character into String buffer
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 2 == 0 && enteredData.length != index) {
        buffer.write(":");
      }
    }

    return TextEditingValue(
        text: buffer.toString(), // final generated credit card number
        selection: TextSelection.collapsed(
            offset: buffer.toString().length) // keep the cursor at end
        );
  }
}

class MinMaxNumberFormatter extends TextInputFormatter {
  final int min;
  final int max;
  final bool acceptEmpty;

  MinMaxNumberFormatter({
    this.min = 0,
    required this.max,
    this.acceptEmpty = false,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      final initValue = acceptEmpty ? '' : '$min';
      return TextEditingValue(
          text: initValue, // final generated credit card number
          selection: TextSelection(
              baseOffset: 0,
              extentOffset: initValue.length) // keep the cursor at end
          );
    }
    String enteredData = newValue.text; // get data enter by used in textField
    StringBuffer buffer = StringBuffer();

    final intValue = int.tryParse(enteredData);
    final exceedMax = (intValue ?? (max + 1)) > max;
    if (exceedMax) {
      buffer.clear();
      buffer.write(max);
    } else {
      buffer.write(intValue);
    }
    return TextEditingValue(
        text: buffer.toString(), // final generated credit card number
        selection: exceedMax
            ? TextSelection(
                baseOffset: 0, extentOffset: buffer.toString().length)
            : TextSelection.collapsed(
                offset: buffer.toString().length) // keep the cursor at end
        );
  }
}
