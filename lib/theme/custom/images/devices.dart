import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/utils/named.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:privacygui_widgets/utils/svg.dart';

class AppDevicesData extends Equatable {
  const AppDevicesData({
    required this.routerWhw01,
    required this.routerWhw03,
    required this.routerMr7350,
    required this.routerEa8300,
    required this.routerMx6200,
    required this.routerWhw03b,
    required this.routerEa9350,
    required this.routerLn12,
    required this.routerWhw01p,
    required this.routerLn11,
    required this.routerMx5300,
    required this.routerWhw01b,
    required this.routerMr7500,
    required this.routerMr6350,
  });

  factory AppDevicesData.dark() => const AppDevicesData(
        routerWhw01: AssetImage('assets/images/devices/router-whw01.png',
            package: 'privacygui_widgets'),
        routerWhw03: AssetImage('assets/images/devices/router-whw03.png',
            package: 'privacygui_widgets'),
        routerMr7350: AssetImage('assets/images/devices/router-mr7350.png',
            package: 'privacygui_widgets'),
        routerEa8300: AssetImage('assets/images/devices/router-ea8300.png',
            package: 'privacygui_widgets'),
        routerMx6200: AssetImage('assets/images/devices/router-mx6200.png',
            package: 'privacygui_widgets'),
        routerWhw03b: AssetImage('assets/images/devices/router-whw03b.png',
            package: 'privacygui_widgets'),
        routerEa9350: AssetImage('assets/images/devices/router-ea9350.png',
            package: 'privacygui_widgets'),
        routerLn12: AssetImage('assets/images/devices/router-ln12.png',
            package: 'privacygui_widgets'),
        routerWhw01p: AssetImage('assets/images/devices/router-whw01p.png',
            package: 'privacygui_widgets'),
        routerLn11: AssetImage('assets/images/devices/router-ln11.png',
            package: 'privacygui_widgets'),
        routerMx5300: AssetImage('assets/images/devices/router-mx5300.png',
            package: 'privacygui_widgets'),
        routerWhw01b: AssetImage('assets/images/devices/router-whw01b.png',
            package: 'privacygui_widgets'),
        routerMr7500: AssetImage('assets/images/devices/router-mr7500.png',
            package: 'privacygui_widgets'),
        routerMr6350: AssetImage('assets/images/devices/router-mr6350.png',
            package: 'privacygui_widgets'),
      );
  factory AppDevicesData.light() => const AppDevicesData(
        routerWhw01: AssetImage('assets/images/devices/router-whw01.png',
            package: 'privacygui_widgets'),
        routerWhw03: AssetImage('assets/images/devices/router-whw03.png',
            package: 'privacygui_widgets'),
        routerMr7350: AssetImage('assets/images/devices/router-mr7350.png',
            package: 'privacygui_widgets'),
        routerEa8300: AssetImage('assets/images/devices/router-ea8300.png',
            package: 'privacygui_widgets'),
        routerMx6200: AssetImage('assets/images/devices/router-mx6200.png',
            package: 'privacygui_widgets'),
        routerWhw03b: AssetImage('assets/images/devices/router-whw03b.png',
            package: 'privacygui_widgets'),
        routerEa9350: AssetImage('assets/images/devices/router-ea9350.png',
            package: 'privacygui_widgets'),
        routerLn12: AssetImage('assets/images/devices/router-ln12.png',
            package: 'privacygui_widgets'),
        routerWhw01p: AssetImage('assets/images/devices/router-whw01p.png',
            package: 'privacygui_widgets'),
        routerLn11: AssetImage('assets/images/devices/router-ln11.png',
            package: 'privacygui_widgets'),
        routerMx5300: AssetImage('assets/images/devices/router-mx5300.png',
            package: 'privacygui_widgets'),
        routerWhw01b: AssetImage('assets/images/devices/router-whw01b.png',
            package: 'privacygui_widgets'),
        routerMr7500: AssetImage('assets/images/devices/router-mr7500.png',
            package: 'privacygui_widgets'),
        routerMr6350: AssetImage('assets/images/devices/router-mr6350.png',
            package: 'privacygui_widgets'),
      );

  final ImageProvider routerWhw01;
  final ImageProvider routerWhw03;
  final ImageProvider routerMr7350;
  final ImageProvider routerEa8300;
  final ImageProvider routerMx6200;
  final ImageProvider routerWhw03b;
  final ImageProvider routerEa9350;
  final ImageProvider routerLn12;
  final ImageProvider routerWhw01p;
  final ImageProvider routerLn11;
  final ImageProvider routerMx5300;
  final ImageProvider routerWhw01b;
  final ImageProvider routerMr7500;
  final ImageProvider routerMr6350;

  @override
  List<Named<dynamic>> get props => [
        routerWhw01.named('routerWhw01'),
        routerWhw03.named('routerWhw03'),
        routerMr7350.named('routerMr7350'),
        routerEa8300.named('routerEa8300'),
        routerMx6200.named('routerMx6200'),
        routerWhw03b.named('routerWhw03b'),
        routerEa9350.named('routerEa9350'),
        routerLn12.named('routerLn12'),
        routerWhw01p.named('routerWhw01p'),
        routerLn11.named('routerLn11'),
        routerMx5300.named('routerMx5300'),
        routerWhw01b.named('routerWhw01b'),
        routerMr7500.named('routerMr7500'),
        routerMr6350.named('routerMr6350'),
      ];
}
