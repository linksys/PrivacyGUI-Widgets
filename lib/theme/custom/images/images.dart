  import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/utils/named.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:privacygui_widgets/utils/svg.dart';
import './devices_xl.dart';
import './devices.dart';



  class AppImagesData extends Equatable {
    const AppImagesData({
      required this.ledRedSolid,
required this.openDns,
required this.nodeLightSolidRed,
required this.modemIdentifying,
required this.nodeLightSolidBlue,
required this.nodeLightBlinkRed,
required this.imgRouterBlack,
required this.ledBlueBlink,
required this.nodeLightBlinkYellow,
required this.imgMoveNodes,
required this.nodeLightBlinkBlue,
required this.imgPlaceWiredNodes,
required this.nodeLightSolidWhite,
required this.internetToDevice,
required this.linksysWordmark,
required this.internetToRouter,
required this.ledWhiteSolid,
required this.nodeLightBlinkWhite,
required this.ledPurpleSolid,
required this.imgWiredMoveNodes,
required this.ledYellowSolid,
required this.ledRedBlink,
required this.modemPlugged,
required this.noInternetConnection,
required this.fortinetDns,
required this.imgRouterWhite,
required this.ledBlueSolid,
required this.devices_xl,
required this.imgPortOff,
required this.imgAddNodes,
required this.linksysLogoBlack,
required this.dashboardLogo,
required this.chromePrivacyErr,
required this.modemWaiting,
required this.btnCheckSpeeds,
required this.nodeLightOff,
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
nodeLightSolidRed: exactAssetPicture('assets/images/node_light_solid_red.svg', package: 'privacygui_widgets', filter: const {"#ff1a1c1e":"#ffaeaeae"}),
modemIdentifying: exactAssetPicture('assets/images/modem_identifying.svg', package: 'privacygui_widgets'),
nodeLightSolidBlue: exactAssetPicture('assets/images/node_light_solid_blue.svg', package: 'privacygui_widgets', filter: const {"#ff1a1c1e":"#ffaeaeae"}),
nodeLightBlinkRed: exactAssetPicture('assets/images/node_light_blink_red.svg', package: 'privacygui_widgets', filter: const {"#ff1a1c1e":"#ffaeaeae"}),
imgRouterBlack: exactAssetPicture('assets/images/img_router_black.svg', package: 'privacygui_widgets'),
ledBlueBlink: exactAssetPicture('assets/images/led_blue_blink.svg', package: 'privacygui_widgets'),
nodeLightBlinkYellow: exactAssetPicture('assets/images/node_light_blink_yellow.svg', package: 'privacygui_widgets', filter: const {"#ff1a1c1e":"#ffaeaeae"}),
imgMoveNodes: exactAssetPicture('assets/images/img_move_nodes.svg', package: 'privacygui_widgets', filter: const {"#ff000000":"#ffffffff"}),
nodeLightBlinkBlue: exactAssetPicture('assets/images/node_light_blink_blue.svg', package: 'privacygui_widgets', filter: const {"#ff1a1c1e":"#ffaeaeae"}),
imgPlaceWiredNodes: exactAssetPicture('assets/images/img_place_wired_nodes.svg', package: 'privacygui_widgets'),
nodeLightSolidWhite: exactAssetPicture('assets/images/node_light_solid_white.svg', package: 'privacygui_widgets', filter: const {"#ff1a1c1e":"#ffaeaeae"}),
internetToDevice: exactAssetPicture('assets/images/internet_to_device.svg', package: 'privacygui_widgets', filter: const {"#FFD9D9D9":"#ffffffff","#FF44474F":"#ffffffff"}),
linksysWordmark: exactAssetPicture('assets/images/linksys_wordmark.svg', package: 'privacygui_widgets'),
internetToRouter: exactAssetPicture('assets/images/internet_to_router.svg', package: 'privacygui_widgets', filter: const {"#FFD9D9D9":"#ffffffff","#FF44474F":"#ffffffff"}),
ledWhiteSolid: exactAssetPicture('assets/images/led_white_solid.svg', package: 'privacygui_widgets'),
nodeLightBlinkWhite: exactAssetPicture('assets/images/node_light_blink_white.svg', package: 'privacygui_widgets', filter: const {"#ff1a1c1e":"#ffaeaeae"}),
ledPurpleSolid: exactAssetPicture('assets/images/led_purple_solid.svg', package: 'privacygui_widgets'),
imgWiredMoveNodes: exactAssetPicture('assets/images/img_wired_move_nodes.svg', package: 'privacygui_widgets'),
ledYellowSolid: exactAssetPicture('assets/images/led_yellow_solid.svg', package: 'privacygui_widgets'),
ledRedBlink: exactAssetPicture('assets/images/led_red_blink.svg', package: 'privacygui_widgets'),
modemPlugged: exactAssetPicture('assets/images/modem_plugged.svg', package: 'privacygui_widgets'),
noInternetConnection: exactAssetPicture('assets/images/no_internet_connection.svg', package: 'privacygui_widgets'),
fortinetDns: const AssetImage('assets/images/fortinet_dns.png', package: 'privacygui_widgets'),
imgRouterWhite: exactAssetPicture('assets/images/img_router_white.svg', package: 'privacygui_widgets'),
ledBlueSolid: exactAssetPicture('assets/images/led_blue_solid.svg', package: 'privacygui_widgets'),
devices_xl: AppDevices_xlData.dark(),imgPortOff: exactAssetPicture('assets/images/img_port_off.svg', package: 'privacygui_widgets'),
imgAddNodes: exactAssetPicture('assets/images/img_add_nodes.svg', package: 'privacygui_widgets', filter: const {"#ff231F20":"#fff3f3f3","#ff000000":"#ffffffff"}),
linksysLogoBlack: exactAssetPicture('assets/images/linksys_logo_black.svg', package: 'privacygui_widgets', filter: const {"#ff000000":"#ffffffff"}),
dashboardLogo: const AssetImage('assets/logo_dark/dashboard_logo_dark.png', package: 'privacygui_widgets'),
chromePrivacyErr: const AssetImage('assets/images/chrome_privacy_err.png', package: 'privacygui_widgets'),
modemWaiting: exactAssetPicture('assets/images/modem_waiting.svg', package: 'privacygui_widgets'),
btnCheckSpeeds: exactAssetPicture('assets/images/btn_check_speeds.svg', package: 'privacygui_widgets'),
nodeLightOff: exactAssetPicture('assets/images/node_light_off.svg', package: 'privacygui_widgets'),
pnpFinishDesktop: exactAssetPicture('assets/images/pnp_finish_desktop.svg', package: 'privacygui_widgets'),
ledWhiteBlink: exactAssetPicture('assets/images/led_white_blink.svg', package: 'privacygui_widgets'),
speedtestPowered: const AssetImage('assets/images/speedtest_powered.png', package: 'privacygui_widgets'),
imgPortOn: exactAssetPicture('assets/images/img_port_on.svg', package: 'privacygui_widgets', filter: const {"#ff74777f":"#ff008a2d"}),
ledPurpleBlink: exactAssetPicture('assets/images/led_purple_blink.svg', package: 'privacygui_widgets'),
devices: AppDevicesData.dark(),modemDevice: exactAssetPicture('assets/images/modem_device.svg', package: 'privacygui_widgets'),

    );
    factory AppImagesData.light() => AppImagesData(
      ledRedSolid: exactAssetPicture('assets/images/led_red_solid.svg', package: 'privacygui_widgets'),
openDns: const AssetImage('assets/images/open_dns.png', package: 'privacygui_widgets'),
nodeLightSolidRed: exactAssetPicture('assets/images/node_light_solid_red.svg', package: 'privacygui_widgets'),
modemIdentifying: exactAssetPicture('assets/images/modem_identifying.svg', package: 'privacygui_widgets'),
nodeLightSolidBlue: exactAssetPicture('assets/images/node_light_solid_blue.svg', package: 'privacygui_widgets'),
nodeLightBlinkRed: exactAssetPicture('assets/images/node_light_blink_red.svg', package: 'privacygui_widgets'),
imgRouterBlack: exactAssetPicture('assets/images/img_router_black.svg', package: 'privacygui_widgets'),
ledBlueBlink: exactAssetPicture('assets/images/led_blue_blink.svg', package: 'privacygui_widgets'),
nodeLightBlinkYellow: exactAssetPicture('assets/images/node_light_blink_yellow.svg', package: 'privacygui_widgets'),
imgMoveNodes: exactAssetPicture('assets/images/img_move_nodes.svg', package: 'privacygui_widgets'),
nodeLightBlinkBlue: exactAssetPicture('assets/images/node_light_blink_blue.svg', package: 'privacygui_widgets'),
imgPlaceWiredNodes: exactAssetPicture('assets/images/img_place_wired_nodes.svg', package: 'privacygui_widgets'),
nodeLightSolidWhite: exactAssetPicture('assets/images/node_light_solid_white.svg', package: 'privacygui_widgets'),
internetToDevice: exactAssetPicture('assets/images/internet_to_device.svg', package: 'privacygui_widgets'),
linksysWordmark: exactAssetPicture('assets/images/linksys_wordmark.svg', package: 'privacygui_widgets', filter: const {"#ffffffff":"#ff000000"}),
internetToRouter: exactAssetPicture('assets/images/internet_to_router.svg', package: 'privacygui_widgets'),
ledWhiteSolid: exactAssetPicture('assets/images/led_white_solid.svg', package: 'privacygui_widgets'),
nodeLightBlinkWhite: exactAssetPicture('assets/images/node_light_blink_white.svg', package: 'privacygui_widgets'),
ledPurpleSolid: exactAssetPicture('assets/images/led_purple_solid.svg', package: 'privacygui_widgets'),
imgWiredMoveNodes: exactAssetPicture('assets/images/img_wired_move_nodes.svg', package: 'privacygui_widgets'),
ledYellowSolid: exactAssetPicture('assets/images/led_yellow_solid.svg', package: 'privacygui_widgets'),
ledRedBlink: exactAssetPicture('assets/images/led_red_blink.svg', package: 'privacygui_widgets'),
modemPlugged: exactAssetPicture('assets/images/modem_plugged.svg', package: 'privacygui_widgets'),
noInternetConnection: exactAssetPicture('assets/images/no_internet_connection.svg', package: 'privacygui_widgets'),
fortinetDns: const AssetImage('assets/images/fortinet_dns.png', package: 'privacygui_widgets'),
imgRouterWhite: exactAssetPicture('assets/images/img_router_white.svg', package: 'privacygui_widgets'),
ledBlueSolid: exactAssetPicture('assets/images/led_blue_solid.svg', package: 'privacygui_widgets'),
devices_xl: AppDevices_xlData.light(),imgPortOff: exactAssetPicture('assets/images/img_port_off.svg', package: 'privacygui_widgets'),
imgAddNodes: exactAssetPicture('assets/images/img_add_nodes.svg', package: 'privacygui_widgets'),
linksysLogoBlack: exactAssetPicture('assets/images/linksys_logo_black.svg', package: 'privacygui_widgets'),
dashboardLogo: const AssetImage('assets/images/dashboard_logo.png', package: 'privacygui_widgets'),
chromePrivacyErr: const AssetImage('assets/images/chrome_privacy_err.png', package: 'privacygui_widgets'),
modemWaiting: exactAssetPicture('assets/images/modem_waiting.svg', package: 'privacygui_widgets'),
btnCheckSpeeds: exactAssetPicture('assets/images/btn_check_speeds.svg', package: 'privacygui_widgets'),
nodeLightOff: exactAssetPicture('assets/images/node_light_off.svg', package: 'privacygui_widgets'),
pnpFinishDesktop: exactAssetPicture('assets/images/pnp_finish_desktop.svg', package: 'privacygui_widgets'),
ledWhiteBlink: exactAssetPicture('assets/images/led_white_blink.svg', package: 'privacygui_widgets'),
speedtestPowered: const AssetImage('assets/images/speedtest_powered.png', package: 'privacygui_widgets'),
imgPortOn: exactAssetPicture('assets/images/img_port_on.svg', package: 'privacygui_widgets', filter: const {"#ff74777f":"#ff008a2d"}),
ledPurpleBlink: exactAssetPicture('assets/images/led_purple_blink.svg', package: 'privacygui_widgets'),
devices: AppDevicesData.light(),modemDevice: exactAssetPicture('assets/images/modem_device.svg', package: 'privacygui_widgets'),

    );

    final SvgLoader ledRedSolid;
final ImageProvider openDns;
final SvgLoader nodeLightSolidRed;
final SvgLoader modemIdentifying;
final SvgLoader nodeLightSolidBlue;
final SvgLoader nodeLightBlinkRed;
final SvgLoader imgRouterBlack;
final SvgLoader ledBlueBlink;
final SvgLoader nodeLightBlinkYellow;
final SvgLoader imgMoveNodes;
final SvgLoader nodeLightBlinkBlue;
final SvgLoader imgPlaceWiredNodes;
final SvgLoader nodeLightSolidWhite;
final SvgLoader internetToDevice;
final SvgLoader linksysWordmark;
final SvgLoader internetToRouter;
final SvgLoader ledWhiteSolid;
final SvgLoader nodeLightBlinkWhite;
final SvgLoader ledPurpleSolid;
final SvgLoader imgWiredMoveNodes;
final SvgLoader ledYellowSolid;
final SvgLoader ledRedBlink;
final SvgLoader modemPlugged;
final SvgLoader noInternetConnection;
final ImageProvider fortinetDns;
final SvgLoader imgRouterWhite;
final SvgLoader ledBlueSolid;
final AppDevices_xlData devices_xl;final SvgLoader imgPortOff;
final SvgLoader imgAddNodes;
final SvgLoader linksysLogoBlack;
final ImageProvider dashboardLogo;
final ImageProvider chromePrivacyErr;
final SvgLoader modemWaiting;
final SvgLoader btnCheckSpeeds;
final SvgLoader nodeLightOff;
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
nodeLightSolidRed.named('nodeLightSolidRed'),
modemIdentifying.named('modemIdentifying'),
nodeLightSolidBlue.named('nodeLightSolidBlue'),
nodeLightBlinkRed.named('nodeLightBlinkRed'),
imgRouterBlack.named('imgRouterBlack'),
ledBlueBlink.named('ledBlueBlink'),
nodeLightBlinkYellow.named('nodeLightBlinkYellow'),
imgMoveNodes.named('imgMoveNodes'),
nodeLightBlinkBlue.named('nodeLightBlinkBlue'),
imgPlaceWiredNodes.named('imgPlaceWiredNodes'),
nodeLightSolidWhite.named('nodeLightSolidWhite'),
internetToDevice.named('internetToDevice'),
linksysWordmark.named('linksysWordmark'),
internetToRouter.named('internetToRouter'),
ledWhiteSolid.named('ledWhiteSolid'),
nodeLightBlinkWhite.named('nodeLightBlinkWhite'),
ledPurpleSolid.named('ledPurpleSolid'),
imgWiredMoveNodes.named('imgWiredMoveNodes'),
ledYellowSolid.named('ledYellowSolid'),
ledRedBlink.named('ledRedBlink'),
modemPlugged.named('modemPlugged'),
noInternetConnection.named('noInternetConnection'),
fortinetDns.named('fortinetDns'),
imgRouterWhite.named('imgRouterWhite'),
ledBlueSolid.named('ledBlueSolid'),
devices_xl.named('devices_xl'),imgPortOff.named('imgPortOff'),
imgAddNodes.named('imgAddNodes'),
linksysLogoBlack.named('linksysLogoBlack'),
dashboardLogo.named('dashboardLogo'),
chromePrivacyErr.named('chromePrivacyErr'),
modemWaiting.named('modemWaiting'),
btnCheckSpeeds.named('btnCheckSpeeds'),
nodeLightOff.named('nodeLightOff'),
pnpFinishDesktop.named('pnpFinishDesktop'),
ledWhiteBlink.named('ledWhiteBlink'),
speedtestPowered.named('speedtestPowered'),
imgPortOn.named('imgPortOn'),
ledPurpleBlink.named('ledPurpleBlink'),
devices.named('devices'),modemDevice.named('modemDevice'),

    ];
  }
  