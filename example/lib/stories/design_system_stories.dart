part of '../storybook.dart';

Iterable<Story> designSystemStories() {
  final tonalPalettesArray = [
    0,
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    95,
    99,
    100
  ];
  return [
    Story(
      name: 'Design System/Color Scheme',
      builder: (context) => GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
        children: [
          _colorGrid(
              color: Theme.of(context).colorScheme.primary, label: 'Primary'),
          _colorGrid(
              color: Theme.of(context).colorScheme.secondary,
              label: 'Secondary'),
          _colorGrid(
              color: Theme.of(context).colorScheme.tertiary, label: 'Tertiary'),
          _colorGrid(
              color: Theme.of(context).colorScheme.error, label: 'Error'),

          ///
          _colorGrid(
              color: Theme.of(context).colorScheme.onPrimary,
              label: 'On Primary'),
          _colorGrid(
              color: Theme.of(context).colorScheme.onSecondary,
              label: 'On Secondary'),
          _colorGrid(
              color: Theme.of(context).colorScheme.onTertiary,
              label: 'On Tertiary'),
          _colorGrid(
              color: Theme.of(context).colorScheme.onError, label: 'On Error'),

          ///
          _colorGrid(
              color: Theme.of(context).colorScheme.primaryContainer,
              label: 'Primary Container'),
          _colorGrid(
              color: Theme.of(context).colorScheme.secondaryContainer,
              label: 'Secondary Container'),
          _colorGrid(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              label: 'Tertiary Container'),
          _colorGrid(
              color: Theme.of(context).colorScheme.errorContainer,
              label: 'Error Container'),

          ///
          _colorGrid(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              label: 'On Primary Container'),
          _colorGrid(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              label: 'On Secondary Container'),
          _colorGrid(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              label: 'On Tertiary Container'),
          _colorGrid(
              color: Theme.of(context).colorScheme.onErrorContainer,
              label: 'On Error Container'),

          ///
          _colorGrid(
              color:
                  Theme.of(context).colorSchemeExt.primaryFixed,
              label: 'Primary Fixed'),
          _colorGrid(
              color:
                  Theme.of(context).colorSchemeExt.secondaryFixed,
              label: 'Secondary Fixed'),
          _colorGrid(
              color:
                  Theme.of(context).colorSchemeExt.tertiaryFixed,
              label: 'Tertiary Fixed'),
          const Center(),

          ///
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  ?.primaryFixedDim,
              label: 'Primary Fixed Dim'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  ?.secondaryFixedDim,
              label: 'Secondary Fixed Dim'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  ?.tertiaryFixedDim,
              label: 'Tertiary Fixed Dim'),
          const Center(),

          ///
          _colorGrid(
              color:
                  Theme.of(context).colorSchemeExt.onPrimaryFixed,
              label: 'On Primary Fixed'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  ?.onSecondaryFixed,
              label: 'On Secondary Fixed'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  ?.onTertiaryFixed,
              label: 'On Tertiary Fixed'),
          const Center(),

          ///
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  ?.onPrimaryFixedVariant,
              label: 'On Primary Fixed Variant'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  ?.onSecondaryFixedVariant,
              label: 'On Secondary Fixed Variant'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  ?.onTertiaryFixedVariant,
              label: 'On Tertiary Fixed Variant'),
          const Center(),

          ///
          _colorGrid(
              color: Theme.of(context).colorSchemeExt.surfaceDim,
              label: 'Surface Dim'),
          _colorGrid(
              color: Theme.of(context).colorScheme.surface, label: 'Surface'),
          _colorGrid(
              color:
                  Theme.of(context).colorSchemeExt.surfaceBright,
              label: 'Surface Bright'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  .surfaceContainerLowest,
              label: 'Surface Container Lowest'),

          ///
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  .surfaceContainerLow,
              label: 'Surface Container Low'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  .surfaceContainer,
              label: 'Surface Container'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  .surfaceContainerHigh,
              label: 'Surface Container High'),
          _colorGrid(
              color: Theme.of(context)
                  .colorSchemeExt
                  .surfaceContainerHighest,
              label: 'Surface Container Highest'),

          ///
          _colorGrid(
              color: Theme.of(context).colorScheme.inverseSurface,
              label: 'Inverse Surface'),
          _colorGrid(
              color: Theme.of(context).colorScheme.onInverseSurface,
              label: 'Inverse On Surface'),
          _colorGrid(
              color: Theme.of(context).colorScheme.inversePrimary,
              label: 'Inverse Primary'),
          const Center(),

          ///
          _colorGrid(
              color: Theme.of(context).colorScheme.onSurface,
              label: 'On Surface'),
          _colorGrid(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              label: 'Inverse Surface Variant'),
          _colorGrid(
              color: Theme.of(context).colorScheme.outline, label: 'Outline'),
          _colorGrid(
              color: Theme.of(context).colorScheme.outlineVariant,
              label: 'Outline Variant'),

          ///
          _colorGrid(
              color: Theme.of(context).colorScheme.scrim, label: 'Scrim'),
          _colorGrid(
              color: Theme.of(context).colorScheme.shadow, label: 'Shadow'),
        ],
      ),
    ),
    Story(
      name: 'Design System/Typography',
      builder: (context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.from(AppTextLevel.values.map(
              (e) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: AppText(
                  e.toString(),
                  textLevel: e,
                ),
              ),
            )),
          ],
        ),
      ),
    ),
    Story(
      name: 'Design System/Tonal Palettes',
      builder: (context) => SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                      width: 120, child: AppText.labelMedium('Primary')),
                  ...tonalPalettesArray
                      .map((e) => Container(
                            width: 40,
                            height: 40,
                            color: Color(primaryTonal.get(e)),
                            child: Center(
                                child: AppText.bodySmall(
                              '$e',
                              color: _invertColor(Color(primaryTonal.get(e))),
                            )),
                          ))
                      .toList(),
                ],
              ),
              const AppGap.regular(),
              Row(
                children: [
                  const SizedBox(
                      width: 120, child: AppText.labelMedium('Secondary')),
                  ...tonalPalettesArray
                      .map((e) => Container(
                            width: 40,
                            height: 40,
                            color: Color(secondaryTonal.get(e)),
                            child: Center(
                                child: AppText.bodySmall(
                              '$e',
                              color: _invertColor(Color(primaryTonal.get(e))),
                            )),
                          ))
                      .toList(),
                ],
              ),
              const AppGap.regular(),
              Row(
                children: [
                  const SizedBox(
                      width: 120, child: AppText.labelMedium('Tertiary')),
                  ...tonalPalettesArray
                      .map((e) => Container(
                            width: 40,
                            height: 40,
                            color: Color(tertiartyTonal.get(e)),
                            child: Center(
                                child: AppText.bodySmall(
                              '$e',
                              color: _invertColor(Color(primaryTonal.get(e))),
                            )),
                          ))
                      .toList(),
                ],
              ),
              const AppGap.regular(),
              Row(
                children: [
                  const SizedBox(
                      width: 120, child: AppText.labelMedium('Error')),
                  ...tonalPalettesArray
                      .map((e) => Container(
                            width: 40,
                            height: 40,
                            color: Color(errorTonal.get(e)),
                            child: Center(
                                child: AppText.bodySmall(
                              '$e',
                              color: _invertColor(Color(primaryTonal.get(e))),
                            )),
                          ))
                      .toList(),
                ],
              ),
              const AppGap.regular(),
              Row(
                children: [
                  const SizedBox(
                      width: 120, child: AppText.labelMedium('Neutral')),
                  ...tonalPalettesArray
                      .map((e) => Container(
                            width: 40,
                            height: 40,
                            color: Color(neutralTonal.get(e)),
                            child: Center(
                                child: AppText.bodySmall(
                              '$e',
                              color: _invertColor(Color(primaryTonal.get(e))),
                            )),
                          ))
                      .toList(),
                ],
              ),
              const AppGap.regular(),
              Row(
                children: [
                  const SizedBox(
                      width: 120,
                      child: AppText.labelMedium('Neutral Variant')),
                  ...tonalPalettesArray
                      .map((e) => Container(
                            width: 40,
                            height: 40,
                            color: Color(neutralVariantTonal.get(e)),
                            child: Center(
                                child: AppText.bodySmall(
                              '$e',
                              color: _invertColor(Color(primaryTonal.get(e))),
                            )),
                          ))
                      .toList(),
                ],
              ),
              const AppGap.regular(),
              Row(
                children: [
                  const SizedBox(
                      width: 120, child: AppText.labelMedium('Green')),
                  ...tonalPalettesArray
                      .map((e) => Container(
                            width: 40,
                            height: 40,
                            color: Color(greenTonal.get(e)),
                            child: Center(
                                child: AppText.bodySmall(
                              '$e',
                              color: _invertColor(Color(primaryTonal.get(e))),
                            )),
                          ))
                      .toList(),
                ],
              ),
              const AppGap.regular(),
              Row(
                children: [
                  const SizedBox(
                      width: 120, child: AppText.labelMedium('Orange')),
                  ...tonalPalettesArray
                      .map((e) => Container(
                            width: 40,
                            height: 40,
                            color: Color(orangeTonal.get(e)),
                            child: Center(
                                child: AppText.bodySmall(
                              '$e',
                              color: _invertColor(Color(primaryTonal.get(e))),
                            )),
                          ))
                      .toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ];
}

Widget _colorGrid({Color? color, String? label}) {
  return Container(
    color: color,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: AppText.labelSmall(
            '${color?.value.toRadixString(16)}',
            color: _invertColor(color),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AppText.labelSmall(
            label ?? '',
            color: _invertColor(color),
          ),
        ),
      ],
    ),
  );
}

Color _invertColor(Color? color) => color == null
    ? Colors.white
    : Color.fromARGB(
        color.alpha, 255 - color.red, 255 - color.green, 255 - color.blue);
