part of '../storybook.dart';

Iterable<Story> inputStories() {
  TextEditingController controller = TextEditingController();
  TextEditingController errorStyleController = TextEditingController();
  errorStyleController.text = 'johndoe@gmailcom';
  TextEditingController approvedStyleController = TextEditingController();
  TextEditingController filledStyleController = TextEditingController();
  filledStyleController.text = 'johndoe@gmailcom';
  TextEditingController errorFilledStyleController = TextEditingController();
  errorFilledStyleController.text = 'johndoe@gmailcom';
  return [
    Story(
      name: 'Widgets/Input/Pin code input',
      description: 'A custom Text widget used in app',
      builder: (context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppPinCodeInput(
              length: 4,
              onChanged: (value) {},
              onCompleted: (value) {},
            ),
            AppPinCodeInput(
              length: 4,
              enabled: false,
              onChanged: (value) {},
              onCompleted: (value) {},
            ),
            const AppGap.big(),
          ],
        ),
      ),
    ),
    Story(
      name: 'Widgets/Input/Input field - Underline style',
      builder: (context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _textFieldDisplay(
              'basic',
              AppTextField(
                controller: controller,
                hintText: 'Email or phone number',
                descriptionText: 'This is description content',
              ),
            ),
            _textFieldDisplay(
              'w/ suffix icon',
              AppTextField(
                controller: controller,
                hintText: 'Email or phone number',
                suffixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
              ),
            ),
            _textFieldDisplay(
              'w/ prefix icon',
              AppTextField(
                controller: controller,
                hintText: 'Email or phone number',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
              ),
            ),
            _textFieldDisplay(
              'w/ header',
              AppTextField(
                controller: controller,
                hintText: 'Email or phone number',
                headerText: 'Password',
              ),
            ),
            _textFieldDisplay(
              'w/ header and suffix icon',
              AppTextField(
                controller: controller,
                hintText: 'Email or phone number',
                headerText: 'Password',
                suffixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
              ),
            ),
            _textFieldDisplay(
              'w/ header and prefix icon',
              AppTextField(
                controller: controller,
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
              ),
            ),
            _textFieldDisplay(
              'w/ description',
              AppTextField(
                controller: controller,
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
                descriptionText: 'Search content by keyword',
              ),
            ),
            _textFieldDisplay(
              'w/ error',
              AppTextField(
                controller: controller,
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
                descriptionText: 'Search content by keywork',
                errorText: 'enter a valid text',
              ),
            ),
            _textFieldDisplay(
              'disabled',
              AppTextField(
                controller: controller,
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
                descriptionText: 'Search content by keywork',
                enable: false,
              ),
            ),
            _textFieldDisplay(
              'read only',
              AppTextField(
                controller: controller..text = 'apple',
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
                descriptionText: 'Search content by keywork',
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Widgets/Input/Input field - Outline style',
      builder: (context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _textFieldDisplay(
              'basic',
              AppTextField.outline(
                controller: controller,
                hintText: 'Email or phone number',
                descriptionText: 'This is description content',
              ),
            ),
            _textFieldDisplay(
              'w/ suffix icon',
              AppTextField.outline(
                controller: controller,
                hintText: 'Email or phone number',
                suffixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
              ),
            ),
            _textFieldDisplay(
              'w/ prefix icon',
              AppTextField.outline(
                controller: controller,
                hintText: 'Email or phone number',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
              ),
            ),
            _textFieldDisplay(
              'w/ header',
              AppTextField.outline(
                controller: controller,
                hintText: 'Email or phone number',
                headerText: 'Password',
              ),
            ),
            _textFieldDisplay(
              'w/ header and suffix icon',
              AppTextField.outline(
                controller: controller,
                hintText: 'Email or phone number',
                headerText: 'Password',
                suffixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
              ),
            ),
            _textFieldDisplay(
              'w/ header and prefix icon',
              AppTextField.outline(
                controller: controller,
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
              ),
            ),
            _textFieldDisplay(
              'w/ description',
              AppTextField.outline(
                controller: controller,
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
                descriptionText: 'Search content by keyword',
              ),
            ),
            _textFieldDisplay(
              'w/ error',
              AppTextField.outline(
                controller: controller,
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
                descriptionText: 'Search content by keywork',
                errorText: 'enter a valid text',
              ),
            ),
            _textFieldDisplay(
              'disabled',
              AppTextField.outline(
                controller: controller,
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
                descriptionText: 'Search content by keywork',
                enable: false,
              ),
            ),
            _textFieldDisplay(
              'read only',
              AppTextField.outline(
                controller: controller..text = 'apple',
                hintText: 'Input text here',
                headerText: 'Search',
                prefixIcon: AppIconButton.noPadding(
                  icon: LinksysIcons.help,
                  onTap: () {},
                ),
                descriptionText: 'Search content by keywork',
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Widgets/Input/Password Input field - Underline style',
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _textFieldDisplay(
            'basic',
            AppPasswordField(
              controller: controller,
              hintText: 'Input password',
              descriptionText: 'This is description content',
            ),
          ),
          _textFieldDisplay(
            'validation',
            AppPasswordField.withValidator(
              controller: controller,
              hintText: 'Input password',
              descriptionText: 'This is description content',
              validationLabel: 'Password must have',
              validations: [
                Validation(
                    description: 'length must greater than 8',
                    validator: (text) => text.length >= 8),
                Validation(
                    description: 'length must greater than 10',
                    validator: (text) => text.length >= 10),
                Validation(
                    description: 'length must greater than 12',
                    validator: (text) => text.length >= 12),
                Validation(
                    description: 'A rule description',
                    validator: (text) => text.length >= 8),
              ],
            ),
          ),
        ],
      ),
    ),
    Story(
      name: 'Widgets/Input/Password Input field - Outline style',
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _textFieldDisplay(
            'basic',
            AppPasswordField(
              controller: controller,
              hintText: 'Input password',
              descriptionText: 'This is description content',
              border: const OutlineInputBorder(),
            ),
          ),
          _textFieldDisplay(
            'validation',
            AppPasswordField.withValidator(
              controller: controller,
              hintText: 'Input password',
              descriptionText: 'This is description content',
              border: const OutlineInputBorder(),
              validationLabel: 'Password must have',
              validations: [
                Validation(
                    description: 'length must greater than 8',
                    validator: (text) => text.length >= 8),
                Validation(
                    description: 'length must greater than 10',
                    validator: (text) => text.length >= 10),
                Validation(
                    description: 'length must greater than 12',
                    validator: (text) => text.length >= 12),
                Validation(
                    description: 'A rule description',
                    validator: (text) => text.length >= 8),
              ],
            ),
          ),
        ],
      ),
    ),
    Story(
      name: 'Widgets/Input/Formatted input',
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _textFieldDisplay(
            'MAC Address',
            AppTextField.macAddress(
              controller: TextEditingController(),
              hintText: 'MAC address',
            ),
          ),
          _textFieldDisplay(
            'IP Address',
            AppIPFormField(
              controller: TextEditingController(),
            ),
          ),
          _textFieldDisplay(
            'IPv6 Address',
            AppIPv6FormField(
              controller: TextEditingController(),
            ),
          ),
          _textFieldDisplay(
            'Number limation - 1 to 500',
            AppTextField.minMaxNumber(
              min: 1,
              max: 500,
              controller: TextEditingController(),
              hintText: '1 - 500',
            ),
          ),
        ],
      ),
    ),
  ];
}

Widget _textFieldDisplay(String style, Widget inputField) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.titleLarge(style),
        const AppGap.semiSmall(),
        inputField,
      ],
    ),
  );
}

bool _validator() => false;
