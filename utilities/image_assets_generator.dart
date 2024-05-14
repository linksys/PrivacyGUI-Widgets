import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'image_assets_varients_map.dart';

///
/// Use to generate image assets mapping class
/// Please run this under /linksys_widget
///
///
const _outputFolder = './lib/theme/custom/images';

void main(List<String> args) {
  final dir = Directory('./assets/images');
  if (!dir.existsSync()) {
    throw Exception(
        'path is not Directory OR run this under linksys_widget folder');
  }

  processDir(dir);
}

(String, String, String) processDir(Directory dir) {
  print('Processing DIR: ${dir.path}');
  String importString = '''import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/utils/named.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:privacygui_widgets/utils/svg.dart';
''';

  String imageDartFilename = basename(dir.path);
  String constructorPart = '';
  String darkConstructorPart = '';
  String lightConstructorPart = '';
  String classMemberPart = '';
  String propsPart = '';
  final list = dir.listSync();
  list.where((element) {
    final stat = element.statSync();
    return stat.type == FileSystemEntityType.directory ||
        extension(element.path).isNotEmpty;
  }).forEach((element) {
    final stat = element.statSync();
    if (stat.type == FileSystemEntityType.directory) {
      // filename for import, class category, class name
      final results = processDir(element as Directory);
      importString += 'import \'./${results.$1}.dart\';\n';
      constructorPart += 'required this.${results.$2},\n';
      darkConstructorPart += '${results.$2}: ${results.$3}.dark(),';
      lightConstructorPart += '${results.$2}: ${results.$3}.light(),';
      classMemberPart += 'final ${results.$3} ${results.$2};';
      propsPart += '${results.$2}.named(\'${results.$2}\'),';
    } else if (stat.type == FileSystemEntityType.file) {
      final results = processFile(element);
      constructorPart += results.$1;
      darkConstructorPart += results.$2;
      lightConstructorPart += results.$3;
      classMemberPart += results.$4;
      propsPart += results.$5;
    }
  });

  /// const check
  final total = list.length;
  final darkConstCount = darkConstructorPart
      .split('\n')
      .where((element) => element.contains(' const '))
      .length;

  String constPrefix = '';

  if (total == darkConstCount) {
    darkConstructorPart = darkConstructorPart.replaceAll(' const ', ' ');
    lightConstructorPart = lightConstructorPart.replaceAll(' const ', ' ');

    constPrefix = 'const ';
  }

  final classCategoty = basename(dir.path);
  final className = 'App${capitalize(classCategoty)}Data';
  final result = '''
  $importString


  class $className extends Equatable {
    const $className({
      $constructorPart
    });

    factory $className.dark() => $constPrefix$className(
      $darkConstructorPart
    );
    factory $className.light() => $constPrefix$className(
      $lightConstructorPart
    );

    $classMemberPart

    @override
    List<Named<dynamic>> get props =>[
      $propsPart
    ];
  }
  ''';

  final savedFilePath = '$_outputFolder/$imageDartFilename.dart';
  print('Saved File Path: $savedFilePath');
  final dataFile = File('$_outputFolder/$imageDartFilename.dart');
  if (!dataFile.existsSync()) {
    dataFile.createSync(recursive: true);
  }
  dataFile.writeAsStringSync(result);
  return (imageDartFilename, classCategoty, className);
}

(String, String, String, String, String) processFile(FileSystemEntity element) {
  print('Processing FILE: ${element.path}');

  String constructorPart = '';
  String darkConstructorPart = '';
  String lightConstructorPart = '';
  String classMemberPart = '';
  String propsPart = '';
  final fileName = basenameWithoutExtension(element.path);
  final filePath = dirname(element.path).replaceFirst('./', '');
  final ext = extension(element.path);
  bool isSvg = ext == '.svg';
  print('File:: path:$filePath, name:$fileName, ext:$ext');
  String camelName = fileName;
  int dashIndex = camelName.indexOf(RegExp(r'[-_]'));

  // Camel file naming
  while (dashIndex != -1) {
    final letter = camelName.substring(dashIndex + 1, dashIndex + 2);
    camelName =
        camelName.replaceRange(dashIndex, dashIndex + 2, letter.toUpperCase());
    dashIndex = camelName.indexOf(RegExp(r'[-_]'));
  }

  // Remove file extension
  camelName = camelName.replaceAll('.$ext', '');

  // generate class snippet
  final provider = isSvg ? 'SvgLoader' : 'ImageProvider';
  final constructorSnippet = isSvg
      ? createSvgConstructorSnippet(camelName, '$fileName$ext', filePath)
      : createImageConstructorSnippet(camelName, '$fileName$ext', filePath);
  constructorPart += 'required this.$camelName,\n';
  darkConstructorPart += constructorSnippet.$1;
  lightConstructorPart += constructorSnippet.$2;
  classMemberPart += 'final $provider $camelName;\n';
  propsPart += '$camelName.named(\'$camelName\'),\n';

  return (
    constructorPart,
    darkConstructorPart,
    lightConstructorPart,
    classMemberPart,
    propsPart
  );
}

(String, String) createSvgConstructorSnippet(
    String name, String fileName, String filePath) {
  String darkPart = '';
  String lightPart = '';

  // Checking image varient map
  final varientRule = imageVarientsMap[fileName];
  String varientMethod = '';

  varientMethod = varientRule?['method'] as String? ?? '';

  if (varientMethod == 'filter') {
    final darkVarient = varientRule?['dark'] as Map<String, dynamic>?;
    final lightVarient = varientRule?['light'] as Map<String, dynamic>?;
    final darkFilter =
        darkVarient == null ? '' : ', filter: const ${jsonEncode(darkVarient)}';
    final lightFilter = lightVarient == null
        ? ''
        : ', filter: const ${jsonEncode(lightVarient)}';
    darkPart +=
        '$name: exactAssetPicture(\'$filePath/$fileName\', package: \'privacygui_widgets\'$darkFilter),\n';
    lightPart +=
        '$name: exactAssetPicture(\'$filePath/$fileName\', package: \'privacygui_widgets\'$lightFilter),\n';
  } else if (varientMethod == 'file') {
    String? darkVarient = varientRule?['dark'] as String?;
    String? lightVarient = varientRule?['light'] as String?;
    darkPart +=
        '$name: exactAssetPicture(\'$filePath/${darkVarient ?? fileName}\', package: \'privacygui_widgets\'),\n';
    lightPart +=
        '$name: exactAssetPicture(\'$filePath/${lightVarient ?? fileName}\', package: \'privacygui_widgets\'),\n';
  } else {
    darkPart +=
        '$name: exactAssetPicture(\'$filePath/$fileName\', package: \'privacygui_widgets\'),\n';
    lightPart +=
        '$name: exactAssetPicture(\'$filePath/$fileName\', package: \'privacygui_widgets\'),\n';
  }
  return (darkPart, lightPart);
}

(String, String) createImageConstructorSnippet(
    String name, String fileName, String filePath) {
  String darkPart = '';
  String lightPart = '';

  // Checking image varient map
  final varientRule = imageVarientsMap[fileName];
  String varientMethod = '';
  String? darkVarient;
  String? lightVarient;
  if (varientRule != null) {
    varientMethod = varientRule['method'] ?? '';
    darkVarient = varientRule['dark'];
    lightVarient = varientRule['light'];
  }
  if (varientMethod == 'file') {
    darkPart +=
        '$name: const AssetImage(\'$filePath/${darkVarient ?? fileName}\', package: \'privacygui_widgets\'),\n';
    lightPart +=
        '$name: const AssetImage(\'$filePath/${lightVarient ?? fileName}\', package: \'privacygui_widgets\'),\n';
  } else {
    darkPart +=
        '$name: const AssetImage(\'$filePath/$fileName\', package: \'privacygui_widgets\'),\n';
    lightPart +=
        '$name: const AssetImage(\'$filePath/$fileName\', package: \'privacygui_widgets\'),\n';
  }
  return (darkPart, lightPart);
}

String capitalize(String value) {
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
