import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:privacygui_widgets/theme/_theme.dart';

class CustomThemeData extends Equatable {
  const CustomThemeData({
    // required this.icons,
    // required this.colors,
    // required this.typography,
    required this.radius,
    // required this.shadow,
    required this.images,
    // required this.formFactor,
    TargetPlatform? platform,
  }) : _platform = platform;

  factory CustomThemeData.regular(// {required PictureProvider appLogo,}
          ) =>
      CustomThemeData(
        // formFactor: AppFormFactor.medium,
        radius: const AppRadiusData.regular(),
        // shadow: AppShadowsData.regular(),
        images: AppImagesData.light(),
      );

  factory CustomThemeData.withImage(
    AppImagesData images,
  ) =>
      CustomThemeData(
        // formFactor: AppFormFactor.medium,
        radius: const AppRadiusData.regular(),
        // shadow: AppShadowsData.regular(),
        images: images,
      );
  final AppRadiusData radius;

  // final AppShadowsData shadow;
  final AppImagesData images;

  // final AppFormFactor formFactor;
  final TargetPlatform? _platform;

  TargetPlatform get platform => defaultTargetPlatform;

  @override
  List<Object?> get props => [
        // icons,

        radius,
        // shadow,
        images,
        // formFactor,
        platform,
      ];

// AppThemeData withFormFactor(AppFormFactor formFactor) {
//   return AppThemeData(
//     platform: platform,
//     formFactor: formFactor,
//     colors: colors,
//     durations: durations,
//     icons: icons,
//     images: images,
//     radius: radius,
//     shadow: shadow,
//     spacing: spacing,
//     typography: typography,
//   );
// }

// AppThemeData withTypography(AppTypographyData typography) {
//   return AppThemeData(
//     platform: platform,
//     formFactor: formFactor,
//     colors: colors,
//     durations: durations,
//     icons: icons,
//     images: images,
//     radius: radius,
//     shadow: shadow,
//     spacing: spacing,
//     typography: typography,
//   );
// }
}
