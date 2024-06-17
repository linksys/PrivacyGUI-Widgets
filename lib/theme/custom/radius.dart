import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:privacygui_widgets/utils/named.dart';

class AppRadiusData extends Equatable {
  const AppRadiusData({
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
  });

  const AppRadiusData.regular()
      : small = const Radius.circular(4),
        medium = const Radius.circular(8),
        large = const Radius.circular(16),
        extraLarge = const Radius.circular(100);

  final Radius none = Radius.zero;
  final Radius small;
  final Radius medium;
  final Radius large;
  final Radius extraLarge;

  AppBorderRadiusData asBorderRadius() => AppBorderRadiusData(this);

  @override
  List<Object?> get props => [
        none.named('none'),
        small.named('small'),
        medium.named('medium'),
        large.named('large'),
        extraLarge.named('extraLarge'),
      ];
}

class AppBorderRadiusData extends Equatable {
  const AppBorderRadiusData(this._radius);

  BorderRadius get none => BorderRadius.all(_radius.none);
  BorderRadius get small => BorderRadius.all(_radius.small);
  BorderRadius get medium => BorderRadius.all(_radius.medium);
  BorderRadius get large => BorderRadius.all(_radius.large);
  BorderRadius get extraLarge => BorderRadius.all(_radius.extraLarge);

  final AppRadiusData _radius;

  @override
  List<Object?> get props => [_radius];
}
