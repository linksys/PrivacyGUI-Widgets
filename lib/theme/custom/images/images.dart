  import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/utils/named.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:privacygui_widgets/utils/svg.dart';
import './devicesxl.dart';
import './devices.dart';



  class AppImagesData extends Equatable {
    const AppImagesData({
      required this.ledRedSolid,
required this.openDns,
required this.modemIdentifying,
required this.imgRouterBlack,
required this.ledBlueBlink,
required this.imgMoveNodes,
required this.internetToDevice,
required this.tempIllustration,
required this.linksysWordmark,
required this.internetToRouter,
required this.ledWhiteSolid,
required this.brandTinder,
required this.ledPurpleSolid,
required this.signalGood,
required this.ledYellowSolid,
required this.ledRedBlink,
required this.iconEllipse,
required this.modemPlugged,
required this.noInternetConnection,
required this.fortinetDns,
required this.imgRouterWhite,
required this.ledBlueSolid,
required this.imgAddNodes,
required this.linksysLogoBlack,
required this.deviceLaptop,
required this.deviceSmartPhone,
required this.devicesxl,
required this.modemWaiting,
required this.signalExcellent,
required this.pnpFinishDesktop,
required this.ledWhiteBlink,
required this.speedtestPowered,
required this.ledPurpleBlink,
required this.iconEllipseGreen,
required this.devices,
required this.modemDevice,

    });

    factory AppImagesData.dark() => AppImagesData(
      ledRedSolid: exactAssetPicture('assets/images/led_red_solid.svg', package: 'privacygui_widgets'),
openDns: const AssetImage('assets/images/open_dns.png', package: 'privacygui_widgets'),
modemIdentifying: exactAssetPicture('assets/images/modem_identifying.svg', package: 'privacygui_widgets'),
imgRouterBlack: exactAssetPicture('assets/images/img_router_black.svg', package: 'privacygui_widgets'),
ledBlueBlink: exactAssetPicture('assets/images/led_blue_blink.svg', package: 'privacygui_widgets'),
imgMoveNodes: exactAssetPicture('assets/images/img_move_nodes.svg', package: 'privacygui_widgets', filter: const {"#ff000000":"#ffffffff"}),
internetToDevice: exactAssetPicture('assets/images/internet_to_device.svg', package: 'privacygui_widgets', filter: const {"#FFD9D9D9":"#ffffffff","#FF44474F":"#ffffffff"}),
tempIllustration: const AssetImage('assets/images/temp_illustration.png', package: 'privacygui_widgets'),
linksysWordmark: exactAssetPicture('assets/images/linksys_wordmark.svg', package: 'privacygui_widgets'),
internetToRouter: exactAssetPicture('assets/images/internet_to_router.svg', package: 'privacygui_widgets', filter: const {"#FFD9D9D9":"#ffffffff","#FF44474F":"#ffffffff"}),
ledWhiteSolid: exactAssetPicture('assets/images/led_white_solid.svg', package: 'privacygui_widgets'),
brandTinder: const AssetImage('assets/images/brand_tinder.png', package: 'privacygui_widgets'),
ledPurpleSolid: exactAssetPicture('assets/images/led_purple_solid.svg', package: 'privacygui_widgets'),
signalGood: const AssetImage('assets/images/signal_good.png', package: 'privacygui_widgets'),
ledYellowSolid: exactAssetPicture('assets/images/led_yellow_solid.svg', package: 'privacygui_widgets'),
ledRedBlink: exactAssetPicture('assets/images/led_red_blink.svg', package: 'privacygui_widgets'),
iconEllipse: const AssetImage('assets/images/icon_ellipse.png', package: 'privacygui_widgets'),
modemPlugged: exactAssetPicture('assets/images/modem_plugged.svg', package: 'privacygui_widgets'),
noInternetConnection: exactAssetPicture('assets/images/no_internet_connection.svg', package: 'privacygui_widgets'),
fortinetDns: const AssetImage('assets/images/fortinet_dns.png', package: 'privacygui_widgets'),
imgRouterWhite: exactAssetPicture('assets/images/img_router_white.svg', package: 'privacygui_widgets'),
ledBlueSolid: exactAssetPicture('assets/images/led_blue_solid.svg', package: 'privacygui_widgets'),
imgAddNodes: exactAssetPicture('assets/images/img_add_nodes.svg', package: 'privacygui_widgets', filter: const {"#ff231F20":"#fff3f3f3","#ff000000":"#ffffffff"}),
linksysLogoBlack: exactAssetPicture('assets/images/linksys_logo_black.svg', package: 'privacygui_widgets', filter: const {"#ff000000":"#ffffffff"}),
deviceLaptop: const AssetImage('assets/images/device_laptop.png', package: 'privacygui_widgets'),
deviceSmartPhone: const AssetImage('assets/images/device_smart_phone.png', package: 'privacygui_widgets'),
devicesxl: AppDevicesxlData.dark(),modemWaiting: exactAssetPicture('assets/images/modem_waiting.svg', package: 'privacygui_widgets'),
signalExcellent: const AssetImage('assets/images/signal_excellent.png', package: 'privacygui_widgets'),
pnpFinishDesktop: exactAssetPicture('assets/images/pnp_finish_desktop.svg', package: 'privacygui_widgets'),
ledWhiteBlink: exactAssetPicture('assets/images/led_white_blink.svg', package: 'privacygui_widgets'),
speedtestPowered: const AssetImage('assets/images/speedtest_powered.png', package: 'privacygui_widgets'),
ledPurpleBlink: exactAssetPicture('assets/images/led_purple_blink.svg', package: 'privacygui_widgets'),
iconEllipseGreen: const AssetImage('assets/images/icon_ellipse_green.png', package: 'privacygui_widgets'),
devices: AppDevicesData.dark(),modemDevice: exactAssetPicture('assets/images/modem_device.svg', package: 'privacygui_widgets'),

    );
    factory AppImagesData.light() => AppImagesData(
      ledRedSolid: exactAssetPicture('assets/images/led_red_solid.svg', package: 'privacygui_widgets'),
openDns: const AssetImage('assets/images/open_dns.png', package: 'privacygui_widgets'),
modemIdentifying: exactAssetPicture('assets/images/modem_identifying.svg', package: 'privacygui_widgets'),
imgRouterBlack: exactAssetPicture('assets/images/img_router_black.svg', package: 'privacygui_widgets'),
ledBlueBlink: exactAssetPicture('assets/images/led_blue_blink.svg', package: 'privacygui_widgets'),
imgMoveNodes: exactAssetPicture('assets/images/img_move_nodes.svg', package: 'privacygui_widgets'),
internetToDevice: exactAssetPicture('assets/images/internet_to_device.svg', package: 'privacygui_widgets'),
tempIllustration: const AssetImage('assets/images/temp_illustration.png', package: 'privacygui_widgets'),
linksysWordmark: exactAssetPicture('assets/images/linksys_wordmark.svg', package: 'privacygui_widgets', filter: const {"#ffffffff":"#ff000000"}),
internetToRouter: exactAssetPicture('assets/images/internet_to_router.svg', package: 'privacygui_widgets'),
ledWhiteSolid: exactAssetPicture('assets/images/led_white_solid.svg', package: 'privacygui_widgets'),
brandTinder: const AssetImage('assets/images/brand_tinder.png', package: 'privacygui_widgets'),
ledPurpleSolid: exactAssetPicture('assets/images/led_purple_solid.svg', package: 'privacygui_widgets'),
signalGood: const AssetImage('assets/images/signal_good.png', package: 'privacygui_widgets'),
ledYellowSolid: exactAssetPicture('assets/images/led_yellow_solid.svg', package: 'privacygui_widgets'),
ledRedBlink: exactAssetPicture('assets/images/led_red_blink.svg', package: 'privacygui_widgets'),
iconEllipse: const AssetImage('assets/images/icon_ellipse.png', package: 'privacygui_widgets'),
modemPlugged: exactAssetPicture('assets/images/modem_plugged.svg', package: 'privacygui_widgets'),
noInternetConnection: exactAssetPicture('assets/images/no_internet_connection.svg', package: 'privacygui_widgets'),
fortinetDns: const AssetImage('assets/images/fortinet_dns.png', package: 'privacygui_widgets'),
imgRouterWhite: exactAssetPicture('assets/images/img_router_white.svg', package: 'privacygui_widgets'),
ledBlueSolid: exactAssetPicture('assets/images/led_blue_solid.svg', package: 'privacygui_widgets'),
imgAddNodes: exactAssetPicture('assets/images/img_add_nodes.svg', package: 'privacygui_widgets'),
linksysLogoBlack: exactAssetPicture('assets/images/linksys_logo_black.svg', package: 'privacygui_widgets'),
deviceLaptop: const AssetImage('assets/images/device_laptop.png', package: 'privacygui_widgets'),
deviceSmartPhone: const AssetImage('assets/images/device_smart_phone.png', package: 'privacygui_widgets'),
devicesxl: AppDevicesxlData.light(),modemWaiting: exactAssetPicture('assets/images/modem_waiting.svg', package: 'privacygui_widgets'),
signalExcellent: const AssetImage('assets/images/signal_excellent.png', package: 'privacygui_widgets'),
pnpFinishDesktop: exactAssetPicture('assets/images/pnp_finish_desktop.svg', package: 'privacygui_widgets'),
ledWhiteBlink: exactAssetPicture('assets/images/led_white_blink.svg', package: 'privacygui_widgets'),
speedtestPowered: const AssetImage('assets/images/speedtest_powered.png', package: 'privacygui_widgets'),
ledPurpleBlink: exactAssetPicture('assets/images/led_purple_blink.svg', package: 'privacygui_widgets'),
iconEllipseGreen: const AssetImage('assets/images/icon_ellipse_green.png', package: 'privacygui_widgets'),
devices: AppDevicesData.light(),modemDevice: exactAssetPicture('assets/images/modem_device.svg', package: 'privacygui_widgets'),

    );

    final SvgLoader ledRedSolid;
final ImageProvider openDns;
final SvgLoader modemIdentifying;
final SvgLoader imgRouterBlack;
final SvgLoader ledBlueBlink;
final SvgLoader imgMoveNodes;
final SvgLoader internetToDevice;
final ImageProvider tempIllustration;
final SvgLoader linksysWordmark;
final SvgLoader internetToRouter;
final SvgLoader ledWhiteSolid;
final ImageProvider brandTinder;
final SvgLoader ledPurpleSolid;
final ImageProvider signalGood;
final SvgLoader ledYellowSolid;
final SvgLoader ledRedBlink;
final ImageProvider iconEllipse;
final SvgLoader modemPlugged;
final SvgLoader noInternetConnection;
final ImageProvider fortinetDns;
final SvgLoader imgRouterWhite;
final SvgLoader ledBlueSolid;
final SvgLoader imgAddNodes;
final SvgLoader linksysLogoBlack;
final ImageProvider deviceLaptop;
final ImageProvider deviceSmartPhone;
final AppDevicesxlData devicesxl;final SvgLoader modemWaiting;
final ImageProvider signalExcellent;
final SvgLoader pnpFinishDesktop;
final SvgLoader ledWhiteBlink;
final ImageProvider speedtestPowered;
final SvgLoader ledPurpleBlink;
final ImageProvider iconEllipseGreen;
final AppDevicesData devices;final SvgLoader modemDevice;


    @override
    List<Named<dynamic>> get props =>[
      ledRedSolid.named('ledRedSolid'),
openDns.named('openDns'),
modemIdentifying.named('modemIdentifying'),
imgRouterBlack.named('imgRouterBlack'),
ledBlueBlink.named('ledBlueBlink'),
imgMoveNodes.named('imgMoveNodes'),
internetToDevice.named('internetToDevice'),
tempIllustration.named('tempIllustration'),
linksysWordmark.named('linksysWordmark'),
internetToRouter.named('internetToRouter'),
ledWhiteSolid.named('ledWhiteSolid'),
brandTinder.named('brandTinder'),
ledPurpleSolid.named('ledPurpleSolid'),
signalGood.named('signalGood'),
ledYellowSolid.named('ledYellowSolid'),
ledRedBlink.named('ledRedBlink'),
iconEllipse.named('iconEllipse'),
modemPlugged.named('modemPlugged'),
noInternetConnection.named('noInternetConnection'),
fortinetDns.named('fortinetDns'),
imgRouterWhite.named('imgRouterWhite'),
ledBlueSolid.named('ledBlueSolid'),
imgAddNodes.named('imgAddNodes'),
linksysLogoBlack.named('linksysLogoBlack'),
deviceLaptop.named('deviceLaptop'),
deviceSmartPhone.named('deviceSmartPhone'),
devicesxl.named('devicesxl'),modemWaiting.named('modemWaiting'),
signalExcellent.named('signalExcellent'),
pnpFinishDesktop.named('pnpFinishDesktop'),
ledWhiteBlink.named('ledWhiteBlink'),
speedtestPowered.named('speedtestPowered'),
ledPurpleBlink.named('ledPurpleBlink'),
iconEllipseGreen.named('iconEllipseGreen'),
devices.named('devices'),modemDevice.named('modemDevice'),

    ];
  }
  