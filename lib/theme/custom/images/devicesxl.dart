  import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/utils/named.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:privacygui_widgets/utils/svg.dart';



  class AppDevicesxlData extends Equatable {
    const AppDevicesxlData({
      required this.routerMx6200,
required this.routerLn11,

    });

    factory AppDevicesxlData.dark() => AppDevicesxlData(
      routerMx6200: const AssetImage('assets/images/devicesxl/router-mx6200.png', package: 'privacygui_widgets'),
routerLn11: const AssetImage('assets/images/devicesxl/router-ln11.png', package: 'privacygui_widgets'),

    );
    factory AppDevicesxlData.light() => AppDevicesxlData(
      routerMx6200: const AssetImage('assets/images/devicesxl/router-mx6200.png', package: 'privacygui_widgets'),
routerLn11: const AssetImage('assets/images/devicesxl/router-ln11.png', package: 'privacygui_widgets'),

    );

    final ImageProvider routerMx6200;
final ImageProvider routerLn11;


    @override
    List<Named<dynamic>> get props =>[
      routerMx6200.named('routerMx6200'),
routerLn11.named('routerLn11'),

    ];
  }
  