part of '../storybook.dart';

Iterable<Story> checkboxStories() {
  return [
    Story(
      name: 'Widgets/Checkbox',
      builder: (context) => SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText.bodyLarge('Disabled'),
              const AppCheckbox(
                value: false,
              ),
              const AppCheckbox(
                value: false,
                text: 'I agree to Terms & Conditions of Linksys',
              ),
              const AppCheckbox(
                value: true,
              ),
              const AppCheckbox(
                value: true,
                text: 'I agree to Terms & Conditions of Linksys',
              ),
              const AppCheckbox(
                value: null,
                tristate: true,
              ),
              const AppCheckbox(
                value: null,
                tristate: true,
                text: 'I agree to Terms & Conditions of Linksys',
              ),
              const AppGap.semiBig(),
              const AppText.bodyLarge('Enabled'),
              AppCheckbox(
                value: false,
                onChanged: (value) {},
              ),
              AppCheckbox(
                value: false,
                text: 'I agree to Terms & Conditions of Linksys',
                onChanged: (value) {},
              ),
              AppCheckbox(
                value: true,
                onChanged: (value) {},
              ),
              AppCheckbox(
                value: true,
                text: 'I agree to Terms & Conditions of Linksys',
                onChanged: (value) {},
              ),
              AppCheckbox(
                value: null,
                tristate: true,
                onChanged: (value) {},
              ),
              AppCheckbox(
                value: null,
                tristate: true,
                text: 'I agree to Terms & Conditions of Linksys',
                onChanged: (value) {},
              ),
              const AppGap.semiBig(),
              const AppText.bodyLarge('Error state'),
              AppCheckbox(
                value: false,
                onChanged: (value) {},
                isError: true,
              ),
              AppCheckbox(
                value: false,
                isError: true,
                text: 'I agree to Terms & Conditions of Linksys',
                onChanged: (value) {},
              ),
              AppCheckbox(
                value: true,
                onChanged: (value) {},
                isError: true,
              ),
              AppCheckbox(
                value: true,
                text: 'I agree to Terms & Conditions of Linksys',
                onChanged: (value) {},
                isError: true,
              ),
              AppCheckbox(
                value: null,
                tristate: true,
                onChanged: (value) {},
                isError: true,
              ),
              AppCheckbox(
                value: null,
                tristate: true,
                isError: true,
                text: 'I agree to Terms & Conditions of Linksys',
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    ),
  ];
}
