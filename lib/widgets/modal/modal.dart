import 'package:flutter/cupertino.dart';
import 'package:linksys_widgets/icons/linksys_icons.dart';
import 'package:linksys_widgets/theme/_theme.dart';
import 'package:linksys_widgets/theme/const/spacing.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';

class ButtonData {
  const ButtonData({required this.text, this.onClicked});

  final VoidCallback? onClicked;
  final String text;
}

class AppModalLayout extends StatelessWidget {
  final VoidCallback? closeCallback;
  final ImageProvider? image;
  final String? title;
  final String? description;
  final ButtonData? positiveButton;
  final ButtonData? negativeButton;

  const AppModalLayout({
    super.key,
    this.closeCallback,
    this.image,
    this.title,
    this.description,
    this.positiveButton,
    this.negativeButton,
  }) : assert((title != null || description != null) && positiveButton != null);

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    final image = this.image;
    final title = this.title;
    final description = this.description;
    final positiveButton = this.positiveButton;
    final negativeButton = this.negativeButton;
    //
    return Padding(
      padding: const EdgeInsets.all(Spacing.regular),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIconButton(
            icon: LinksysIcons.close,
            padding: const EdgeInsets.all(0),
            onTap: closeCallback,
          ),
          if (image != null) ...[
            const AppGap.big(),
            Center(
              child: Image(
                image: image,
                height: 250,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
          if (title != null || description != null) const AppGap.big(),
          if (title != null) AppText.displayMedium(title),
          if (title != null && description != null) const AppGap.regular(),
          if (description != null)
            AppText.bodyLarge(
              description,
            ),
          if (positiveButton != null || negativeButton != null)
            const AppGap.big(),
          if (positiveButton != null)
            AppFilledButton(
              positiveButton.text,
              onTap: positiveButton.onClicked,
            ),
          if (negativeButton != null)
            AppTextButton(
              negativeButton.text,
              onTap: negativeButton.onClicked,
            ),
        ],
      ),
    );
  }
}
