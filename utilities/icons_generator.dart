import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';

const String iconSetName = 'LinksysIcons';

///
/// This should inut the json file path which from Fontello (https://fontello.com/)
///
///
void main(List<String> args) {
  if (args.isEmpty) {
    throw Exception('Missing icons config json file');
  }
  // read file
  final filePath = args[0];
  final jsonStr = File(filePath).readAsStringSync();
  final json = jsonDecode(jsonStr);
  final prefix = json['css_prefix_text'];
  print('icon prefix: $prefix');
  final iconsMap = json['glyphs'];
  // rename and map to Map Entities
  final List<MapEntry<String, int>> iconMapEntitiesTransform =
      iconsMap.map<MapEntry<String, int>>((element) {
    final name = '$prefix${element['css']}'
        .split('-')
        .mapIndexed((index, element) => index == 0
            ? element
            : '${element[0].toUpperCase()}${element.substring(1).toLowerCase()}')
        .join('');
    final value = element['code'];
    return MapEntry<String, int>(name, int.parse('$value', radix: 16));
  }).toList();
  final Map<String, int> icons = {}..addEntries(iconMapEntitiesTransform);

  final iconDataFile =
      File('./lib/icons/${convertToFileName(iconSetName)}.dart');
  if (!iconDataFile.existsSync()) {
    iconDataFile.createSync(recursive: true);
  }
  final enumString = '''
  // This is generated by icon_map_checker.dart
  import 'package:flutter/widgets.dart';
  import 'package:equatable/equatable.dart';
  import 'package:linksys_widgets/utils/named.dart';
  
  enum $iconSetName {
    ${icons.keys.join(',\n\t\t')}
  }
  ''';
  final jsonString = '''
  const json$iconSetName = {${icons.entries.map((e) => '"${e.key}": 0x${e.value}').toList().join(',\n\t\t')}};
  ''';

  const className = '${iconSetName}Data';
  final classString = '''
  class $className extends Equatable {
    static const fontFamily = $iconSetName;
    
    const $className({
      ${icons.keys.map((e) => 'required this.$e').join(',\n\t\t')}
    });

    factory $className.regular() => $className(
      ${icons.keys.map((e) => '$e : IconData(json$iconSetName[\'$e\']!, fontFamily: \'$iconSetName\', fontPackage: \'linksys_widgets\')').join(',\n\t\t')}
    );

    ${icons.keys.map((e) => 'final IconData $e').join(';\n\t\t')};
    
    @override
    List<Named<IconData>?> get props => [
        ${icons.keys.map((e) => '$e.named(\'$e\')').join(',\n\t\t')}
      ];
  }
  ''';
  final contents = '$enumString\n$jsonString\n$classString';
  iconDataFile.writeAsStringSync(contents);
}

String convertToFileName(String value) {
  var result = value;
  RegExp regex = RegExp(r'[A-Z]{1}');

  regex.allMatches(value).forEach((element) {
    final upper = element.group(0);
    result = result.replaceFirst(upper ?? '', '_${upper?.toLowerCase() ?? ''}');
  });
  if (result.indexOf('_') == 0) {
    result = result.replaceFirst('_', '');
  }
  return result;
}