part of '../storybook.dart';

Iterable<Story> radioStories() {
  return [
    Story(
      name: 'Widgets/Radio List',
      builder: (context) => Center(
        child: AppRadioList(
          items: [
            AppRadioListItem(title: 'Option 1', value: 1),
            AppRadioListItem(title: 'Option 2', value: 2),
            AppRadioListItem(title: 'Option 3', value: 3),
            AppRadioListItem(title: 'Option 4', value: 4),
            AppRadioListItem(title: 'Option 5', value: 5),
          ],
        ),
      ),
    ),
  ];
}
