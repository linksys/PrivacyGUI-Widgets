import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';

enum AppGapSize {
  none,
  gutter,
  small1,
  small2,
  small3,
  medium,
  large1,
  large2,
  large3,
  large4,
}

extension AppGapSizeExtension on AppGapSize {
  double getSpacing() {
    switch (this) {
      case AppGapSize.none:
        return Spacing.zero;
      case AppGapSize.small1:
        return Spacing.small1;
      case AppGapSize.small2:
        return Spacing.small2;
      case AppGapSize.small3:
        return Spacing.small3;
      case AppGapSize.medium:
        return Spacing.medium;
      case AppGapSize.large1:
        return Spacing.large1;
      case AppGapSize.large2:
        return Spacing.large2;
      case AppGapSize.large3:
        return Spacing.large3;
      case AppGapSize.large4:
        return Spacing.large4;
      case AppGapSize.gutter:
        return 0;
    }
  }
}

class AppGap extends StatelessWidget {
  const AppGap(
    this.size, {
    Key? key,
  }) : super(key: key);

  /// 4, [Spacing.small1]
  const AppGap.small1({
    Key? key,
  })  : size = AppGapSize.small1,
        super(key: key);

  /// 8, [Spacing.small2]
  const AppGap.small2({
    Key? key,
  })  : size = AppGapSize.small2,
        super(key: key);

  /// 12, [Spacing.small3]
  const AppGap.small3({
    Key? key,
  })  : size = AppGapSize.small3,
        super(key: key);

  /// 16, [Spacing.medium]
  const AppGap.medium({
    Key? key,
  })  : size = AppGapSize.medium,
        super(key: key);

  /// 20, [Spacing.large1]
  const AppGap.large1({
    Key? key,
  })  : size = AppGapSize.large1,
        super(key: key);

  /// 24, [Spacing.large2]
  const AppGap.large2({
    Key? key,
  })  : size = AppGapSize.large2,
        super(key: key);

  /// 32, [Spacing.large3]
  const AppGap.large3({
    Key? key,
  })  : size = AppGapSize.large3,
        super(key: key);

  /// 48, [Spacing.large4]
  const AppGap.large4({
    Key? key,
  })  : size = AppGapSize.large4,
        super(key: key);

  const AppGap.gutter({
    Key? key,
  })  : size = AppGapSize.gutter,
        super(key: key);
  final AppGapSize size;

  @override
  Widget build(BuildContext context) {
    return Gap(size == AppGapSize.gutter
        ? ResponsiveLayout.columnPadding(context)
        : size.getSpacing());
  }
}
