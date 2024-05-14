import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

class MultipleAlertDialogPage {
  final String title;
  final String buttonText;

  final Widget Function(
      BuildContext context,
      MultiplePagesAlertDialogController controller,
      int current) contentBuilder;

  MultipleAlertDialogPage({
    required this.title,
    required this.contentBuilder,
    required this.buttonText,
  });
}

class MultiplePagesAlertDialogController {
  void goTo(index) {}
  void close() {}
}

class MultiplePagesAlertDialog extends StatefulWidget {
  final List<MultipleAlertDialogPage> pages;
  final VoidCallback? onClose;
  const MultiplePagesAlertDialog({
    super.key,
    required this.pages,
    this.onClose,
  });

  @override
  State<MultiplePagesAlertDialog> createState() =>
      _MultiplePagesAlertDialogState();
}

class _MultiplePagesAlertDialogState extends State<MultiplePagesAlertDialog>
    implements MultiplePagesAlertDialogController {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        AppTextButton.noPadding(
          widget.pages[_index].buttonText,
          onTap: () {
            if (_index == 0) {
              close();
            } else {
              goTo(_index - 1);
            }
          },
        )
      ],
      title: AppText.titleLarge(widget.pages[_index].title),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 312),
        child: widget.pages[_index].contentBuilder(context, this, _index),
      ),
    );
  }

  @override
  void close() {
    widget.onClose?.call();
  }

  @override
  void goTo(index) {
    setState(() {
      _index = index;
    });
  }
}
