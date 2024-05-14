import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linksys_widgets/icons/linksys_icons.dart';
import 'package:linksys_widgets/theme/const/spacing.dart';
import 'package:linksys_widgets/utils/named.dart';
import 'package:linksys_widgets/widgets/bullet_list/bullet_list.dart';
import 'package:linksys_widgets/widgets/bullet_list/bullet_style.dart';
import 'package:linksys_widgets/widgets/buttons/popup_button.dart';
import 'package:linksys_widgets/widgets/card/general_card.dart';
import 'package:linksys_widgets/widgets/input_field/ip_form_field.dart';
import 'package:linksys_widgets/widgets/input_field/ipv6_form_field.dart';
import 'package:linksys_widgets/widgets/input_field/validator_widget.dart';
import 'package:linksys_widgets/widgets/page/base_page_view.dart';
import 'package:linksys_widgets/widgets/page/layout/basic_layout.dart';
import 'package:linksys_widgets/widgets/page/layout/profile_header_layout.dart';
import 'package:linksys_widgets/widgets/panel/general_section.dart';
import 'package:linksys_widgets/widgets/progress_bar/full_screen_spinner.dart';
import 'package:linksys_widgets/widgets/radios/radio_list.dart';
import 'package:linksys_widgets/widgets/stepper/app_stepper.dart';
import 'package:linksys_widgets/widgets/topology/tree_item.dart';
import 'package:linksys_widgets/widgets/topology/tree_node.dart';
import 'package:linksys_widgets/widgets/topology/tree_view.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';
import 'package:linksys_widgets/theme/_theme.dart';
import 'package:linksys_widgets/hook/icon_hooks.dart';

part 'stories/button_stories.dart';
part 'stories/checkbox_stories.dart';
part 'stories/switch_stories.dart';
part 'stories/text_stories.dart';
part 'stories/progress_bar_stories.dart';
part 'stories/snackbar_stories.dart';
part 'stories/assets_stories.dart';
part 'stories/modal_stories.dart';
part 'stories/input_stories.dart';
part 'stories/stepper_stories.dart';
part 'stories/panel_stories.dart';
part 'stories/layout_stories.dart';
part 'stories/design_system_stories.dart';
part 'stories/radio_stories.dart';
part 'stories/bullet_list_stories.dart';

void main() => runApp(const MyApp());

final _plugins = initializePlugins(
  initialDeviceFrameData: (
    device: null,
    isFrameVisible: true,
    orientation: Orientation.portrait
  ),
);

/// Use this wrapper to wrap each story into a [MaterialApp] widget.
Widget linksysMaterialWrapper(BuildContext _, Widget? child) => MaterialApp(
      theme: linksysLightThemeData,
      darkTheme: linksysDarkThemeData,
      debugShowCheckedModeBanner: false,
      home: Home(child: child ?? Container()),
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        wrapperBuilder: linksysMaterialWrapper,
        initialStory: 'Theme/Theme Colors',
        plugins: _plugins,
        stories: [
          ...designSystemStories(),
          ...imageStories(),
          ...textStories(),
          ...inputStories(),
          ...buttonStories(),
          ...switchStories(),
          ...checkboxStories(),
          ...radioStories(),
          ...toastStories(),
          ...containerStories(),
          // ...panelStories(),
          ...layoutStories(),
          ...progressBarStories(),
          ...bulletStories(),
        ],
      );
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // bool isDark = false;
  // AppThemeColorMode colorMode = AppThemeColorMode.light;
  // final window = WidgetsBinding.instance.window;

  // AppThemeColorMode getColorMode() {
  //   final themeMode = context.watch<ThemeModeNotifier>().value;
  //   final brightness = themeMode == ThemeMode.system
  //       ? MediaQuery.platformBrightnessOf(context)
  //       : themeMode == ThemeMode.light
  //           ? Brightness.light
  //           : Brightness.dark;
  //   return (brightness == Brightness.light)
  //       ? AppThemeColorMode.light
  //       : AppThemeColorMode.dark;
  // }

  @override
  Widget build(BuildContext context) {
    return CustomResponsive(
      // colorMode: getColorMode(),
      child: Scaffold(
        body: SafeArea(
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
