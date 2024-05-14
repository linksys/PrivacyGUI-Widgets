part of '../storybook.dart';

Iterable<Story> buttonStories() {
  return [
    Story(
      name: 'Widgets/Buttons/Icon Buttons',
      description: 'A custom buttons used in app',
      builder: (context) => Column(
        children: [
          const AppText.bodyLarge('Icon Button'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIconButton(
                icon: LinksysIcons.accountCircle,
                onTap: () {},
              ),
              const AppGap.small(),
              AppIconButton(
                icon: LinksysIcons.accountCircle,
              ),
            ],
          ),
          const AppGap.big(),
          const AppText.bodyLarge('Icon Button Filled'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIconButton.filled(
                icon: LinksysIcons.accountCircle,
                onTap: () {},
              ),
              const AppGap.small(),
              AppIconButton.filled(
                icon: LinksysIcons.accountCircle,
              ),
            ],
          ),
          const AppGap.big(),
          const AppText.bodyLarge('Icon Button Outlined'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIconButton.outlined(
                icon: LinksysIcons.accountCircle,
                onTap: () {},
              ),
              const AppGap.small(),
              AppIconButton.outlined(
                icon: LinksysIcons.accountCircle,
              ),
            ],
          ),
          const AppGap.big(),
          const AppText.bodyLarge('Icon Button Outlined'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIconButton.tonal(
                icon: LinksysIcons.accountCircle,
                onTap: () {},
              ),
              const AppGap.small(),
              AppIconButton.tonal(
                icon: LinksysIcons.accountCircle,
              ),
            ],
          ),
          const AppGap.big(),
          const AppText.bodyLarge('Animated Toggle Button'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIconToggleButton(
                icon1: LinksysIcons.menu,
                icon2: LinksysIcons.close,
                animation: AppTweenAnimationData.leftRotate90,
              ),
              const AppGap.regular(),
              AppIconToggleButton(
                icon1: LinksysIcons.menu,
                icon2: LinksysIcons.close,
                animation: AppTweenAnimationData.leftRotate180,
              ),
              const AppGap.regular(),
              AppIconToggleButton(
                icon1: LinksysIcons.menu,
                icon2: LinksysIcons.close,
                animation: AppTweenAnimationData.leftRotate270,
              ),
              const AppGap.regular(),
              AppIconToggleButton(
                icon1: LinksysIcons.menu,
                icon2: LinksysIcons.close,
                animation: AppTweenAnimationData.leftRotate360,
              ),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Widgets/Buttons/Buttons',
      description: 'A custom buttons used in app',
      builder: (context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText.bodyLarge('Filled Button'),
            AppFilledButton(
              'Filled Button',
              onTap: () {},
            ),
            const AppGap.small(),
            AppFilledButton(
              'Filled Button',
              icon: LinksysIcons.add,
              onTap: () {},
            ),
            const AppGap.small(),
            const AppFilledButton(
              'Filled Button Disabled',
            ),
            const AppGap.small(),
            const AppFilledButton(
              'Filled Button Disabled',
              icon: LinksysIcons.add,
            ),
            const AppGap.big(),
            const AppText.bodyLarge('Text Button'),
            AppTextButton(
              'Text Button',
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Hi!')));
              },
            ),
            const AppGap.small(),
            AppTextButton(
              'Text Button',
              icon: LinksysIcons.add,
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Hi!')));
              },
            ),
            const AppGap.small(),
            const AppTextButton(
              'Text Button Disabled',
            ),
            const AppGap.small(),
            const AppTextButton(
              'Text Button Disabled',
              icon: LinksysIcons.add,
            ),
            const AppGap.big(),
            const AppText.bodyLarge('Outlined Button'),
            AppOutlinedButton(
              'Outlined Button',
              onTap: () {},
            ),
            const AppGap.small(),
            AppOutlinedButton(
              'Outlined Button',
              icon: LinksysIcons.add,
              onTap: () {},
            ),
            const AppGap.small(),
            const AppOutlinedButton(
              'Outlined Button Disabled',
            ),
            const AppGap.small(),
            const AppOutlinedButton(
              'Outlined Button Disabled',
              icon: LinksysIcons.add,
            ),
            const AppGap.big(),
            const AppText.bodyLarge('Elevated Button'),
            AppElevatedButton(
              'Elevated Button',
              onTap: () {},
            ),
            const AppGap.small(),
            AppElevatedButton(
              'Elevated Button',
              icon: LinksysIcons.add,
              onTap: () {},
            ),
            const AppGap.small(),
            const AppElevatedButton(
              'Elevated Button Disabled',
            ),
            const AppGap.small(),
            const AppElevatedButton(
              'Elevated Button Disabled',
              icon: LinksysIcons.add,
            ),
            const AppGap.big(),
            const AppText.bodyLarge('Tonal Button'),
            AppTonalButton(
              'Tonal Button',
              onTap: () {},
            ),
            const AppGap.small(),
            AppTonalButton(
              'Tonal Button ',
              icon: LinksysIcons.add,
              onTap: () {},
            ),
            const AppGap.small(),
            const AppTonalButton(
              'Tonal Button Disabled',
            ),
            const AppGap.small(),
            const AppTonalButton(
              'Tonal Button Disabled',
              icon: LinksysIcons.add,
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Widgets/Buttons/Popup Buttons',
      builder: (context) => SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: AppPopupButton(
                  button: AppTextButton(
                    'Click Me',
                    onTap: () {},
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
            Align(
              alignment: Alignment.topRight,
              child: AppPopupButton(
                  button: AppTextButton(
                    'Click Me',
                    onTap: () {},
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: AppPopupButton(
                  button: Image(
                    image: CustomTheme.of(context).images.devices.routerLn11,
                    width: 72,
                    height: 72,
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
            Align(
              alignment: Alignment.center,
              child: AppPopupButton(
                  button: AppIconButton.outlined(
                    icon: Icons.question_mark_outlined,
                    onTap: () {},
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AppPopupButton(
                  button: AppTextButton(
                    'Click Me',
                    onTap: () {},
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: AppPopupButton(
                  button: AppTextButton(
                    'Click Me',
                    onTap: () {},
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppPopupButton(
                  verticalPosition: AppPopupVerticalPosition.top,
                  button: AppTextButton(
                    'Click Me',
                    onTap: () {},
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AppPopupButton(
                  verticalPosition: AppPopupVerticalPosition.top,
                  button: AppTextButton(
                    'Click Me',
                    onTap: () {},
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: AppPopupButton(
                  verticalPosition: AppPopupVerticalPosition.top,
                  button: AppTextButton(
                    'Click Me',
                    onTap: () {},
                  ),
                  builder: (controller) => const AppText.bodyMedium('Some tips can show here')),
            ),
          ],
        ),
      ),
    ),
  ];
}
