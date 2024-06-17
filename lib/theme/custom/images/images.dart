  import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/utils/named.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:privacygui_widgets/utils/svg.dart';
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
required this.linksysWordmark,
required this.internetToRouter,
required this.ledWhiteSolid,
required this.ledPurpleSolid,
required this.ledYellowSolid,
required this.ledRedBlink,
required this.modemPlugged,
required this.noInternetConnection,
required this.fortinetDns,
required this.imgRouterWhite,
required this.ledBlueSolid,
required this.imgPortOff,
required this.imgAddNodes,
required this.linksysLogoBlack,
required this.modemWaiting,
required this.pnpFinishDesktop,
required this.ledWhiteBlink,
required this.speedtestPowered,
required this.imgPortOn,
required this.ledPurpleBlink,
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
linksysWordmark: exactAssetPicture('assets/images/linksys_wordmark.svg', package: 'privacygui_widgets'),
internetToRouter: exactAssetPicture('assets/images/internet_to_router.svg', package: 'privacygui_widgets', filter: const {"#FFD9D9D9":"#ffffffff","#FF44474F":"#ffffffff"}),
ledWhiteSolid: exactAssetPicture('assets/images/led_white_solid.svg', package: 'privacygui_widgets'),
ledPurpleSolid: exactAssetPicture('assets/images/led_purple_solid.svg', package: 'privacygui_widgets'),
ledYellowSolid: exactAssetPicture('assets/images/led_yellow_solid.svg', package: 'privacygui_widgets'),
ledRedBlink: exactAssetPicture('assets/images/led_red_blink.svg', package: 'privacygui_widgets'),
modemPlugged: exactAssetPicture('assets/images/modem_plugged.svg', package: 'privacygui_widgets'),
noInternetConnection: exactAssetPicture('assets/images/no_internet_connection.svg', package: 'privacygui_widgets'),
fortinetDns: const AssetImage('assets/images/fortinet_dns.png', package: 'privacygui_widgets'),
imgRouterWhite: exactAssetPicture('assets/images/img_router_white.svg', package: 'privacygui_widgets'),
ledBlueSolid: exactAssetPicture('assets/images/led_blue_solid.svg', package: 'privacygui_widgets'),
imgPortOff: exactAssetPicture('assets/images/img_port_off.svg', package: 'privacygui_widgets'),
imgAddNodes: exactAssetPicture('assets/images/img_add_nodes.svg', package: 'privacygui_widgets', filter: const {"#ff231F20":"#fff3f3f3","#ff000000":"#ffffffff"}),
linksysLogoBlack: exactAssetPicture('assets/images/linksys_logo_black.svg', package: 'privacygui_widgets', filter: const {"#ff000000":"#ffffffff"}),
modemWaiting: exactAssetPicture('assets/images/modem_waiting.svg', package: 'privacygui_widgets'),
pnpFinishDesktop: exactAssetPicture('assets/images/pnp_finish_desktop.svg', package: 'privacygui_widgets'),
ledWhiteBlink: exactAssetPicture('assets/images/led_white_blink.svg', package: 'privacygui_widgets'),
speedtestPowered: const AssetImage('assets/images/speedtest_powered.png', package: 'privacygui_widgets'),
imgPortOn: exactAssetPicture('assets/images/img_port_on.svg', package: 'privacygui_widgets'),
ledPurpleBlink: exactAssetPicture('assets/images/led_purple_blink.svg', package: 'privacygui_widgets'),
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
linksysWordmark: exactAssetPicture('assets/images/linksys_wordmark.svg', package: 'privacygui_widgets', filter: const {"#ffffffff":"#ff000000"}),
internetToRouter: exactAssetPicture('assets/images/internet_to_router.svg', package: 'privacygui_widgets'),
ledWhiteSolid: exactAssetPicture('assets/images/led_white_solid.svg', package: 'privacygui_widgets'),
ledPurpleSolid: exactAssetPicture('assets/images/led_purple_solid.svg', package: 'privacygui_widgets'),
ledYellowSolid: exactAssetPicture('assets/images/led_yellow_solid.svg', package: 'privacygui_widgets'),
ledRedBlink: exactAssetPicture('assets/images/led_red_blink.svg', package: 'privacygui_widgets'),
modemPlugged: exactAssetPicture('assets/images/modem_plugged.svg', package: 'privacygui_widgets'),
noInternetConnection: exactAssetPicture('assets/images/no_internet_connection.svg', package: 'privacygui_widgets'),
fortinetDns: const AssetImage('assets/images/fortinet_dns.png', package: 'privacygui_widgets'),
imgRouterWhite: exactAssetPicture('assets/images/img_router_white.svg', package: 'privacygui_widgets'),
ledBlueSolid: exactAssetPicture('assets/images/led_blue_solid.svg', package: 'privacygui_widgets'),
imgPortOff: exactAssetPicture('assets/images/img_port_off.svg', package: 'privacygui_widgets'),
imgAddNodes: exactAssetPicture('assets/images/img_add_nodes.svg', package: 'privacygui_widgets'),
linksysLogoBlack: exactAssetPicture('assets/images/linksys_logo_black.svg', package: 'privacygui_widgets'),
modemWaiting: exactAssetPicture('assets/images/modem_waiting.svg', package: 'privacygui_widgets'),
pnpFinishDesktop: exactAssetPicture('assets/images/pnp_finish_desktop.svg', package: 'privacygui_widgets'),
ledWhiteBlink: exactAssetPicture('assets/images/led_white_blink.svg', package: 'privacygui_widgets'),
speedtestPowered: const AssetImage('assets/images/speedtest_powered.png', package: 'privacygui_widgets'),
imgPortOn: exactAssetPicture('assets/images/img_port_on.svg', package: 'privacygui_widgets'),
ledPurpleBlink: exactAssetPicture('assets/images/led_purple_blink.svg', package: 'privacygui_widgets'),
devices: AppDevicesData.light(),modemDevice: exactAssetPicture('assets/images/modem_device.svg', package: 'privacygui_widgets'),

    );

    final SvgLoader ledRedSolid;
final ImageProvider openDns;
final SvgLoader modemIdentifying;
final SvgLoader imgRouterBlack;
final SvgLoader ledBlueBlink;
final SvgLoader imgMoveNodes;
final SvgLoader internetToDevice;
final SvgLoader linksysWordmark;
final SvgLoader internetToRouter;
final SvgLoader ledWhiteSolid;
final SvgLoader ledPurpleSolid;
final SvgLoader ledYellowSolid;
final SvgLoader ledRedBlink;
final SvgLoader modemPlugged;
final SvgLoader noInternetConnection;
final ImageProvider fortinetDns;
final SvgLoader imgRouterWhite;
final SvgLoader ledBlueSolid;
final SvgLoader imgPortOff;
final SvgLoader imgAddNodes;
final SvgLoader linksysLogoBlack;
final SvgLoader modemWaiting;
final SvgLoader pnpFinishDesktop;
final SvgLoader ledWhiteBlink;
final ImageProvider speedtestPowered;
final SvgLoader imgPortOn;
final SvgLoader ledPurpleBlink;
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
linksysWordmark.named('linksysWordmark'),
internetToRouter.named('internetToRouter'),
ledWhiteSolid.named('ledWhiteSolid'),
ledPurpleSolid.named('ledPurpleSolid'),
ledYellowSolid.named('ledYellowSolid'),
ledRedBlink.named('ledRedBlink'),
modemPlugged.named('modemPlugged'),
noInternetConnection.named('noInternetConnection'),
fortinetDns.named('fortinetDns'),
imgRouterWhite.named('imgRouterWhite'),
ledBlueSolid.named('ledBlueSolid'),
imgPortOff.named('imgPortOff'),
imgAddNodes.named('imgAddNodes'),
linksysLogoBlack.named('linksysLogoBlack'),
modemWaiting.named('modemWaiting'),
pnpFinishDesktop.named('pnpFinishDesktop'),
ledWhiteBlink.named('ledWhiteBlink'),
speedtestPowered.named('speedtestPowered'),
imgPortOn.named('imgPortOn'),
ledPurpleBlink.named('ledPurpleBlink'),
devices.named('devices'),modemDevice.named('modemDevice'),

    ];
  }
  