part of '../storybook.dart';

Iterable<Story> switchStories() {
  return [
    Story(
      name: 'Widgets/Switch',
      builder: (context) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText.labelLarge('Basic'),
            AppSwitch(
              value: true,
              onChanged: (value) {},
            ),
            AppSwitch(
              value: false,
              onChanged: (value) {},
            ),
            const AppSwitch(
              value: true,
            ),
            const AppSwitch(
              value: false,
            ),
            const AppGap.regular(),
            const AppText.labelLarge('With default icons'),
            AppSwitch.withIcon(
              value: true,
              onChanged: (value) {},
            ),
            AppSwitch.withIcon(
              value: false,
              onChanged: (value) {},
            ),
            const AppSwitch.withIcon(
              value: true,
            ),
            const AppSwitch.withIcon(
              value: false,
            ),
            const AppGap.regular(),
            const AppText.labelLarge('With custom icons'),
            AppSwitch.withIcon(
              value: true,
              onChanged: (value) {},
              checkedIcon: const Icon(Icons.add),
              uncheckIcon: const Icon(Icons.remove),
            ),
            AppSwitch.withIcon(
              value: false,
              onChanged: (value) {},
              checkedIcon: const Icon(Icons.add),
              uncheckIcon: const Icon(Icons.remove),
            ),
            const AppSwitch.withIcon(
              value: true,
              checkedIcon: Icon(Icons.add),
              uncheckIcon: Icon(Icons.remove),
            ),
            const AppSwitch.withIcon(
              value: false,
              checkedIcon: Icon(Icons.add),
              uncheckIcon: Icon(Icons.remove),
            ),
            const AppGap.regular(),
          ],
        ),
      ),
    ),
  ];
}
