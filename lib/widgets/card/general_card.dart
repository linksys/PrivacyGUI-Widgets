import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

class GeneralCard extends StatelessWidget {
  const GeneralCard({
    super.key,
    this.iconData,
    this.image,
    this.title,
    this.description,
    this.maxHeight = 360,
    this.maxWidth = 360,
    this.minHeight = 0,
    this.minWidth = 0,
    this.alignCenter = true,
  });

  final IconData? iconData;
  final ImageProvider? image;
  final String? title;
  final String? description;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final bool alignCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        minWidth: minWidth,
        minHeight: minHeight,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: alignCenter
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: alignCenter
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Tooltip(
                    message: title ?? '',
                    waitDuration: Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: iconData != null
                            ? Icon(
                                iconData,
                              )
                            : image != null
                                ? Image(
                                    image: image!,
                                    fit: BoxFit.fitHeight,
                                    width: maxWidth == double.infinity
                                        ? null
                                        : maxWidth,
                                    height: maxHeight == double.infinity
                                        ? null
                                        : maxHeight,
                                  )
                                : const Center(),
                      ),
                    ),
                  ),
                ),
                if (title != null)
                  AppText.bodyLarge(
                    title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                if (description != null)
                  AppText.bodySmall(
                    description ?? '',
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
