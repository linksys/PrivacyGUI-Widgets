part of '../storybook.dart';

Iterable<Story> toastStories() {
  return [
    Story(
      name: 'Widgets/Snackbar/Custom Snackbar',
      builder: (context) => const Column(
        children: [
          AppToast.positive(
            text: 'Biometric sign on enabled',
          ),
          AppGap.medium(),
          AppToast.negative(
            text: 'Biometric sign on enabled',
          ),
        ],
      ),
    ),
    Story(
      name: 'Widgets/Snackbar/Show Snackbar',
      builder: (context) => Column(
        children: [
          AppFilledButton(
            'Show Positive Custom Snackbar',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                AppToastHelp.positiveToast(context,
                    text: 'Biometric sign on enabled'),
              );
            },
          ),
          const AppGap.medium(),
          AppFilledButton(
            'Show Negative Custom Snackbar',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                AppToastHelp.negativeToast(context,
                    text: 'Biometric sign on enabled'),
              );
            },
          ),
          const AppGap.medium(),
          AppFilledButton(
            'Show Default Snackbar',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: AppText.bodyMedium(
                  'Single-line snackbar with close affordance',
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ));
            },
          ),
          const AppGap.medium(),
          AppFilledButton(
            'Show Default Snackbar with Close',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                showCloseIcon: true,
                content: AppText.bodyMedium(
                  'Single-line snackbar with close affordance',
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ));
            },
          ),
          const AppGap.medium(),
          AppFilledButton(
            'Show Default Snackbar with Action',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                showCloseIcon: true,
                content: AppText.bodyMedium(
                  'Single-line snackbar with close affordance',
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
                action: SnackBarAction(label: 'Action', onPressed: () {}),
              ));
            },
          ),
        ],
      ),
    ),
  ];
}
