part of '../storybook.dart';

Iterable<Story> layoutStories() {
  return [
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
                    AppGap.large3(),
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
