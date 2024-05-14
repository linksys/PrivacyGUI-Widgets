import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/theme/custom/avatars.dart';

class CustomThemeData extends Equatable {
  const CustomThemeData({
    // required this.icons,
    // required this.colors,
    // required this.typography,
    required this.radius,
    // required this.shadow,
    required this.durations,
    required this.images,
    required this.avatar,
    // required this.formFactor,
    TargetPlatform? platform,
  }) : _platform = platform;

  factory CustomThemeData.regular(// {required PictureProvider appLogo,}
          ) =>
      CustomThemeData(
        // formFactor: AppFormFactor.medium,
        radius: const AppRadiusData.regular(),
        // shadow: AppShadowsData.regular(),
        durations: AppDurationsData.regular(),
        images: AppImagesData.light(),
        avatar: AppAvatarSizesData.regular(),
      );

  factory CustomThemeData.withImage(
    AppImagesData images,
  ) =>
      CustomThemeData(
        // formFactor: AppFormFactor.medium,
        radius: const AppRadiusData.regular(),
        // shadow: AppShadowsData.regular(),
        durations: AppDurationsData.regular(),
        images: images,
        avatar: AppAvatarSizesData.regular(),
      );
  final AppRadiusData radius;

  // final AppShadowsData shadow;
  final AppDurationsData durations;
  final AppImagesData images;
  final AppAvatarSizesData avatar;

  // final AppFormFactor formFactor;
  final TargetPlatform? _platform;

  TargetPlatform get platform => defaultTargetPlatform;

  @override
  List<Object?> get props => [
        // icons,

        radius,
        // shadow,
        durations,
        images,
        avatar,
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
