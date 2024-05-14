import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:privacygui_widgets/theme/const/spacing.dart';

enum AppGapSize {
  none,
  small,
  semiSmall,
  regular,
  semiBig,
  big,
  extraBig,
}

extension AppGapSizeExtension on AppGapSize {
  double getSpacing() {
    switch (this) {
      case AppGapSize.none:
        return 0;
      case AppGapSize.small:
        return Spacing.small;
      case AppGapSize.semiSmall:
        return Spacing.semiSmall;
      case AppGapSize.regular:
        return Spacing.regular;
      case AppGapSize.semiBig:
        return Spacing.semiBig;
      case AppGapSize.big:
        return Spacing.big;
      case AppGapSize.extraBig:
        return Spacing.extraBig;
    }
  }
}

class AppGap extends StatelessWidget {
  const AppGap(
    this.size, {
    Key? key,
  }) : super(key: key);

  /// 4
  const AppGap.small({
    Key? key,
  })  : size = AppGapSize.small,
        super(key: key);

  /// 8
  const AppGap.semiSmall({
    Key? key,
  })  : size = AppGapSize.semiSmall,
        super(key: key);

  /// 16
  const AppGap.regular({
    Key? key,
  })  : size = AppGapSize.regular,
        super(key: key);

  /// 24
  const AppGap.semiBig({
    Key? key,
  })  : size = AppGapSize.semiBig,
        super(key: key);

  /// 32
  const AppGap.big({
    Key? key,
  })  : size = AppGapSize.big,
        super(key: key);

  /// 48
  const AppGap.extraBig({
    Key? key,
  })  : size = AppGapSize.extraBig,
        super(key: key);

  final AppGapSize size;

  @override
  Widget build(BuildContext context) {
    return Gap(size.getSpacing());
  }
}
