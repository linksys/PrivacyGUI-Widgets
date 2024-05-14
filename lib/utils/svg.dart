import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

SvgAssetLoader exactAssetPicture(String assetPath,
    {Map<String, String>? filter, String? package}) {
  final loader = SvgAssetLoader(
    assetPath,
    packageName: package ?? 'privacygui_widgets',
    colorMapper: MyColorMap(replacemantMap: filter ?? {}),
  );
  return loader;
}

class MyColorMap extends ColorMapper {
  final Map<String, String> replacemantMap;
  final Map<Color, Color> _colorMap = {};
  MyColorMap({
    this.replacemantMap = const {},
  }) {
    final colorMap = replacemantMap.entries
        .map((e) => MapEntry(
            Color(int.parse(e.key.replaceAll('#', ''), radix: 16)),
            Color(int.parse(e.value.replaceAll('#', ''), radix: 16))))
        .toList();
    _colorMap.addAll(Map.fromEntries(colorMap));
  }

  @override
  Color substitute(
      String? id, String elementName, String attributeName, Color color) {
    if (_colorMap.containsKey(color)) {
      return _colorMap[color]!;
    }
    return color;
  }
}
