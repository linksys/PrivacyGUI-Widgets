part of '../storybook.dart';

Iterable<Story> containerStories() {
  return [
    Story(
      name: 'Widgets/Stepper',
      builder: (context) => _CustomStepper(),
    ),
  ];
}

class _CustomStepper extends StatefulWidget {
  @override
  State<_CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<_CustomStepper> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return AppStepper(
      type: context.knobs
          .options(label: 'Type', initial: StepperType.horizontal, options: [
        const Option(label: 'Vertical', value: StepperType.vertical),
        const Option(label: 'Horizontal', value: StepperType.horizontal),
      ]),
      currentStep: _index,
      controlsBuilder: context.knobs.boolean(
        label: 'Use Custom Buttom',
        initial: false,
      )
          ? (context, details) {
              return Row(
                children: [
                  AppIconButton(
                    icon: Icons.check,
                    onTap: () {
                      details.onStepContinue?.call();
                    },
                  ),
                  AppIconButton(
                    icon: Icons.close,
                    onTap: () {
                      details.onStepCancel?.call();
                    },
                  ),
                ],
              );
            }
          : null,
      onStepContinue: () {
        if (_index + 1 < 4) {
          setState(() {
            _index++;
          });
        }
      },
      onStepCancel: () {
        if (_index - 1 >= 0) {
          setState(() {
            _index--;
          });
        }
      },
      steps: [
        Step(
          isActive: _index == 0,
          state: _index > 0
              ? StepState.complete
              : _index == 0
                  ? StepState.editing
                  : StepState.indexed,
          title: const AppText.labelLarge('Welcome!'),
          content: const Center(
            child: AppText.labelMedium('Step 1'),
          ),
        ),
        Step(
          isActive: _index == 1,
          state: _index > 1
              ? StepState.complete
              : _index == 1
                  ? StepState.editing
                  : StepState.indexed,
          title: const AppText.labelLarge('WiFi Settings'),
          content: const Center(
            child: AppText.labelMedium('Step 2'),
          ),
        ),
        Step(
          isActive: _index == 2,
          state: _index > 2
              ? StepState.complete
              : _index == 2
                  ? StepState.editing
                  : StepState.indexed,

          title: const AppText.labelLarge('Night Mode'),
          // ignore: prefer_const_constructors
          content: Center(
            child: const AppText.labelMedium('Step 3'),
          ),
        ),
        Step(
          isActive: _index == 3,
          state: _index > 3
              ? StepState.complete
              : _index == 3
                  ? StepState.editing
                  : StepState.indexed,
          title: const AppText.labelLarge('Safe Browsing'),
          content: const Center(
            child: AppText.labelMedium('Step 4'),
          ),
        ),
      ],
    );
  }
}
