part of '../storybook.dart';

Iterable<Story> layoutStories() {
  return [
    Story(
      name: 'Layout/Basic Page Layout',
      description: '',
      builder: (context) => AppPageView(
        appBar: LinksysAppBar(title: const AppText.headlineMedium('AppBar')),
        scrollable: true,
        child: AppBasicLayout(
          header: Container(
              width: double.infinity,
              color: Colors.amber,
              child: const AppText.headlineMedium('Header')),
          content: Column(
            children: [
              Row(
                children: [
                  GeneralCard(
                    iconData: LinksysIcons.wifi,
                    title: 'WiFi',
                    maxHeight: 240,
                    maxWidth: 240,
                  ),
                  GeneralCard(
                    image: CustomTheme.of(context).images.devices.routerWhw03,
                    title: 'Devices',
                    maxHeight: 240,
                    maxWidth: 240,
                  ),
                ],
              )
            ],
          ),
          footer: Container(
              color: Colors.blueGrey,
              width: double.infinity,
              child: Column(
                children: [
                  AppFilledButton(
                    'Footer',
                    onTap: () {},
                  ),
                  const AppGap.regular(),
                  AppFilledButton(
                    'Footer 2',
                    onTap: () {},
                  ),
                ],
              )),
        ),
      ),
    ),
    Story(
      name: 'Layout/Expandable Page Layout',
      description: '',
      builder: (context) => AppPageView(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return AppProfileHeaderLayout(
              expandedHeight: constraint.maxHeight / 2,
              collaspeTitle: 'Collasped Title',
              onCollaspeBackTap: () {},
              background: Theme.of(context).colorScheme.primaryContainer,
              header: Column(
                children: [
                  LinksysAppBar(
                    
                    title: AppText.headlineMedium('Expended title'),
                  ),
                  AppText.displayMedium('Scroll it!'),
                  const Spacer(),
                  // _header(state),
                ],
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                color: Colors.blueGrey,
                child: Column(
                  children: [
                    AppGap.extraBig(),
                    AppSection.withList(items: [
                      AppSectionItemData(title: 'item 1'),
                      AppSectionItemData(title: 'item 2'),
                      AppSectionItemData(title: 'item 3'),
                      AppSectionItemData(title: 'item 4'),
                    ])
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  ];
}
