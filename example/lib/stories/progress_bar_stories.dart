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
          AppGap.medium(),
          AppProgressBar(),
          AppGap.large2(),
          AppText.labelMedium('Linear style 2'),
          AppGap.medium(),
          LinearProgressIndicator(),
          AppGap.large2(),
          AppText.labelMedium('Circular style 1'),
          AppGap.medium(),
          AppProgressBar(
            style: AppProgressBarStyle.circular,
          ),
          AppText.labelMedium('Circular style 2'),
          AppGap.medium(),
          CircularProgressIndicator(),
          AppGap.large2(),
          AppText.labelMedium('Lottie animation'),
          AppGap.medium(),
          AppFullScreenSpinner(),
        ],
      ),
    ),
  ];
}
