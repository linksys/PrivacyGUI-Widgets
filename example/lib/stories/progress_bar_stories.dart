part of '../storybook.dart';

Iterable<Story> progressBarStories() {
  return [
    Story(
      name: 'Widgets/Progress',
      builder: (context) => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.labelMedium('Linear style 1'),
          AppGap.regular(),
          AppProgressBar(),
          AppGap.big(),
          AppText.labelMedium('Linear style 2'),
          AppGap.regular(),
          LinearProgressIndicator(),
          AppGap.big(),
          AppText.labelMedium('Circular style 1'),
          AppGap.regular(),
          AppProgressBar(
            style: AppProgressBarStyle.circular,
          ),
          AppText.labelMedium('Circular style 2'),
          AppGap.regular(),
          CircularProgressIndicator(),
          AppGap.big(),
          AppText.labelMedium('Lottie animation'),
          AppGap.regular(),
          AppFullScreenSpinner(),
        ],
      ),
    ),
  ];
}
