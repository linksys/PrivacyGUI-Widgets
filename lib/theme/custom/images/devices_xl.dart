  import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/utils/named.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:privacygui_widgets/utils/svg.dart';



  class AppDevices_xlData extends Equatable {
    const AppDevices_xlData({
      required this.routerMx6200,
required this.routerLn12,

    });

    factory AppDevices_xlData.dark() => const AppDevices_xlData(
      routerMx6200: AssetImage('assets/images/devices_xl/router-mx6200.png', package: 'privacygui_widgets'),
routerLn12: AssetImage('assets/images/devices_xl/router-ln12.png', package: 'privacygui_widgets'),

    );
    factory AppDevices_xlData.light() => const AppDevices_xlData(
      routerMx6200: AssetImage('assets/images/devices_xl/router-mx6200.png', package: 'privacygui_widgets'),
routerLn12: AssetImage('assets/images/devices_xl/router-ln12.png', package: 'privacygui_widgets'),

    );

    final ImageProvider routerMx6200;
final ImageProvider routerLn12;


    @override
    List<Named<dynamic>> get props =>[
      routerMx6200.named('routerMx6200'),
routerLn12.named('routerLn12'),

    ];
  }
  