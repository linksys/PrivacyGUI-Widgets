part of '../storybook.dart';

Iterable<Story> panelStories() {
  bool testSwitchValue = true;
  return [
    Story(
      name: 'AppPanel/AppPanelWithSimpleTitle',
      description: 'A general panel with title-value widely used in app',
      builder: (context) => Column(
        children: [
          AppSimplePanel(
            title: 'NETWORK',
            titleColorSet: AppWidgetStateColorSet(
              inactive: Theme.of(context).colorScheme.primary,
              hovered: Theme.of(context).colorScheme.primary,
              pressed: Theme.of(context).colorScheme.primary,
              disabled: Theme.of(context).colorScheme.primary,
            ),
          ),
          const AppSimplePanel(
            title: 'Title',
          ),
          AppSimplePanel(
            title: 'Title',
            onTap: () {},
          ),
          AppSimplePanel(
            title: 'NETWORK',
            titleColorSet: AppWidgetStateColorSet(
              inactive: Theme.of(context).colorScheme.primary,
              hovered: Theme.of(context).colorScheme.primary,
              pressed: Theme.of(context).colorScheme.primary,
              disabled: Theme.of(context).colorScheme.primary,
            ),
            description: 'Description text',
          ),
          const AppSimplePanel(
            title: 'Title',
            description: 'Description text',
          ),
          AppSimplePanel(
            title: 'Title',
            description: 'Description text',
            onTap: () {},
          ),
        ],
      ),
    ),
    Story(
        name: 'AppPanel/AppPanelWithInfo',
        description: 'A general panel with title-value widely used in app',
        builder: (context) => Column(
              children: [
                const AppPanelWithInfo(
                  title: 'Title',
                  infoText: 'information',
                ),
                const AppPanelWithInfo(
                  title: 'Title',
                  infoText: 'information',
                  description: 'Description text',
                ),
                AppPanelWithInfo(
                  title: 'Title',
                  infoText: 'information',
                  description: 'Description text',
                  onTap: () {},
                ),
                AppPanelWithInfo(
                  title: 'Title',
                  infoText: 'On',
                  onTap: () {},
                ),
                AppPanelWithInfo(
                  title: 'Title',
                  infoText: 'Failed',
                  description: 'Description text',
                ),
              ],
            )),
    Story(
        name: 'AppPanel/AppPanelWithValueCheck',
        description: 'A general panel with title-value widely used in app',
        builder: (context) => Column(
              children: [
                const AppPanelWithValueCheck(
                  title: 'Title',
                  valueText: 'Status',
                ),
                const AppPanelWithValueCheck(
                  title: 'Title',
                  valueText: 'Status',
                  isChecked: true,
                ),
                AppPanelWithValueCheck(
                  title: 'Title',
                  valueText: 'Status',
                  isChecked: true,
                ),
                const AppPanelWithValueCheck(
                  title: 'Title',
                  description: 'Description text',
                  valueText: 'Status',
                ),
                const AppPanelWithValueCheck(
                  title: 'Title',
                  description: 'Description text',
                  valueText: 'Status',
                  isChecked: true,
                ),
                AppPanelWithValueCheck(
                  title: 'Title',
                  description: 'Description text',
                  valueText: 'Status',
                  isChecked: true,
                ),
              ],
            )),
    Story(
      name: 'AppPanel/AppPanelWithSwitch',
      description: 'A general panel with title-value widely used in app',
      builder: (context) => Column(
        children: [
          AppPanelWithSwitch(
            title: 'Title',
            value: testSwitchValue,
            onChangedEvent: (value) {},
          ),
          AppPanelWithSwitch(
            title: 'Title',
            value: testSwitchValue,
            description: 'Description text',
            onChangedEvent: (value) {},
          ),
          AppPanelWithSwitch(
            title: 'Title',
            value: testSwitchValue,
            onChangedEvent: (value) {},
            onInfoEvent: () {},
          ),
          AppPanelWithSwitch(
            title: 'MeetandGreetSingles',
            description: 'Mature topics',
            image: CustomTheme.of(context).images.brandTinder,
            value: testSwitchValue,
            onChangedEvent: (value) {},
          ),
        ],
      ),
    ),
    Story(
      name: 'AppPanel/AppPanelWithTimeline',
      description: 'A general panel with title-value widely used in app',
      builder: (context) => Column(
        children: [
          AppPanelWithTimeline(
            title: 'MeetandGreetSingles',
            description: 'Mature topics',
            time: '11:20 pm',
            profileName: 'Timmy',
            brandImage: CustomTheme.of(context).images.brandTinder,
            profileImage: CustomTheme.of(context).images.tempIllustration,
          ),
          AppPanelWithTimeline(
            title: 'MeetandGreetSingles',
            description: 'Mature topics',
            time: '11:20 pm',
            profileName: 'Timmy',
            profileImage: CustomTheme.of(context).images.tempIllustration,
          ),
          const AppPanelWithTimeline(
            title: 'MeetandGreetSingles',
            description: 'Mature topics',
            time: '11:20 pm',
            profileName: 'Timmy',
          ),
        ],
      ),
    ),
    Story(
      name: 'AppPanel/AppDevicePanel.normal',
      description: 'A general panel with title-value widely used in app',
      builder: (context) => Column(
        children: [
          AppDevicePanel.normal(
            title: 'Google Pixel',
            place: 'Living Room node',
            band: '2.4 GHz',
            deviceImage: CustomTheme.of(context).images.deviceSmartPhone,
            rssiIcon: LinksysIcons.signalWifi0Bar,
          ),
          AppDevicePanel.normal(
            title: 'Google Pixel',
            place: 'Living Room node',
            band: '2.4 GHz',
            deviceImage: CustomTheme.of(context).images.deviceSmartPhone,
            rssiIcon: LinksysIcons.networkWifi1Bar,
            onTap: () {},
          )
        ],
      ),
    ),
    Story(
      name: 'AppPanel/AppDevicePanel.speed',
      description: 'A general panel with title-value widely used in app',
      builder: (context) => Column(
        children: [
          AppDevicePanel.speed(
            title: 'Macbook Pro',
            place: 'Living Room node',
            frequency: '5 GHz',
            deviceImage: CustomTheme.of(context).images.deviceLaptop,
            rssiIcon: LinksysIcons.networkWifi2Bar,
            upload: 12,
            download: 0.4,
          )
        ],
      ),
    ),
    Story(
      name: 'AppPanel/AppDevicePanel.bandwidth',
      description: 'A general panel with title-value widely used in app',
      builder: (context) => Column(
        children: [
          AppDevicePanel.bandwidth(
            title: 'Google Pixel',
            deviceImage: CustomTheme.of(context).images.deviceSmartPhone,
            bandwidth: 345,
          )
        ],
      ),
    ),
    Story(
      name: 'AppPanel/AppDevicePanel.offline',
      description: 'A general panel with title-value widely used in app',
      builder: (context) => Column(
        children: [
          AppDevicePanel.offline(
            title: 'Google Pixel',
            deviceImage: CustomTheme.of(context).images.deviceSmartPhone,
          ),
          AppDevicePanel.offline(
            title: 'Google Pixel',
            deviceImage: CustomTheme.of(context).images.deviceSmartPhone,
            onTap: () {},
          )
        ],
      ),
    ),
  ];
}
