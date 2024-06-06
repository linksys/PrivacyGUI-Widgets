import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

enum AppStyledTextStyle {
  bold,
  underline,
  italic;
}

class AppStyledText extends StatelessWidget {
  final String text;
  final TextStyle? defaultTextStyle;
  final Map<String, TextStyle> styleTags;
  final Map<String, StyledTextTagActionCallback> callbackTags;

  const AppStyledText(
    this.text, {
    super.key,
    this.defaultTextStyle,
    required this.styleTags,
    required this.callbackTags,
  });

  factory AppStyledText.bold(
    String text, {
    Key? key,
    required TextStyle defaultTextStyle,
    required List<String> tags,
    Color? color,
    Map<String, StyledTextTagActionCallback> callbackTags = const {},
  }) {
    final textStyle =
        defaultTextStyle.copyWith(fontWeight: FontWeight.bold, color: color);
    final styleTags = tags.fold<Map<String, TextStyle>>({}, (map, tag) {
      map[tag] = textStyle;
      return map;
    });
    return AppStyledText(
      text,
      key: key,
      defaultTextStyle: defaultTextStyle,
      styleTags: styleTags,
      callbackTags: callbackTags,
    );
  }

  factory AppStyledText.link(
    String text, {
    Key? key,
    Color? color,
    required TextStyle defaultTextStyle,
    required List<String> tags,
    Map<String, StyledTextTagActionCallback> callbackTags = const {},
  }) {
    final textStyle = defaultTextStyle.copyWith(
        color: color, decoration: TextDecoration.underline);
    final styleTags = tags.fold<Map<String, TextStyle>>({}, (map, tag) {
      map[tag] = textStyle;
      return map;
    });
    return AppStyledText(
      text,
      key: key,
      defaultTextStyle: defaultTextStyle,
      styleTags: styleTags,
      callbackTags: callbackTags,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle =
        defaultTextStyle ?? Theme.of(context).textTheme.bodyMedium;
    final keys = List<String>.from(styleTags.keys)..addAll(callbackTags.keys);
    final tags = keys.fold<Map<String, StyledTextActionTag>>({}, (map, key) {
      map[key] = StyledTextActionTag(callbackTags[key] ?? (text, attributes) {},
          style: styleTags[key] ?? textStyle);
      return map;
    });
    return StyledText(key: key, text: text, style: textStyle, tags: tags);
  }
}
