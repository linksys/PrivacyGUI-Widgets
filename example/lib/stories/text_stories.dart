part of '../storybook.dart';

Iterable<Story> textStories() {
  return [
    Story(
      name: 'Widgets/Styled Text',
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            AppStyledText.link(
              'Lorem ipsum dolor sit amet, visit us at our website <link1 href="www.linksys.com">www.linksys.com</link1>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              color: Theme.of(context).colorScheme.primary,
              defaultTextStyle: Theme.of(context).textTheme.bodyMedium!,
              callbackTags: {
                'link1': (String? text, Map<String?, String?> attrs) {
                  String? link = attrs['href'];
                  print('The "$link" link1 is tapped.');
                }
              },
              tags: const ['link1'],
            ),
            AppStyledText.bold(
              '<b>Lorem ipsum dolor sit amet</b>, visit us at our website <b href="www.linksys.com">www.linksys.com</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              defaultTextStyle: Theme.of(context).textTheme.bodyMedium!,
              tags: const ['b'],
            ),
          ],
        ),
      ),
    ),
  ];
}
