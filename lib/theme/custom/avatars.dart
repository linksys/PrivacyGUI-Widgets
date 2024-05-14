import 'package:equatable/equatable.dart';
import 'package:privacygui_widgets/utils/named.dart';

class AppAvatarSizesData extends Equatable {
  const AppAvatarSizesData({
    required this.extraSmall,
    required this.small,
    required this.normal,
    required this.large,
    required this.extraLarge,
  });

  factory AppAvatarSizesData.regular() => const AppAvatarSizesData(
        extraSmall: 10.0,
        small: 16.0,
        normal: 40.0,
        large: 80.0,
        extraLarge: 120.0,
      );

  final double extraSmall;
  final double small;
  final double normal;
  final double large;
  final double extraLarge;

  @override
  List<Object?> get props => [
        extraSmall.named('extraSmall'),
        small.named('small'),
        normal.named('normal'),
        large.named('large'),
        large.named('extraLarge'),
      ];
}
