part of '../storybook.dart';

Iterable<Story> bulletStories() {
  return [
    Story(
      name: 'Widgets/Bullet List/Unsorted',
      builder: (context) => const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            AppBulletList(
              children: [
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
              ],
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Widgets/Bullet List/Ordered',
      builder: (context) => const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            AppBulletList(
              style: AppBulletStyle.number,
              children: [
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
                AppText.bodyLarge(
                    'Find the modem\'s power, reboot or restart button. Press and hold it. Do not press RESET as it may restore the modem to factory settings. If your modem does not have a power, reboot or restart button, contact your Internet Service Provider for guidance.'),
              ],
            ),
          ],
        ),
      ),
    ),
  ];
}
