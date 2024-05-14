import 'package:flutter/material.dart';
import 'package:linksys_widgets/theme/custom_responsive.dart';

import 'theme/theme.dart';

Widget testableMaterialWidget({required Widget child}) => MaterialApp(
      theme: mockLightThemeData,
      darkTheme: mockDarkThemeData,
      home: Scaffold(
        body: CustomResponsive(
          child: Column(
            children: [child],
          ),
        ),
      ),
    );
