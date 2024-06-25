part of 'custom_responsive.dart';

class _CustomColumnData {
  factory _CustomColumnData() {
    _singleton ??= _CustomColumnData._();
    return _singleton!;
  }

  _CustomColumnData._();

  static _CustomColumnData? _singleton;
  double _size = 0;
  double _gutter = 0;
  void update(double size, double gutter) {
    _size = size;
    _gutter = gutter;
  }
}

extension ColumnExt on int {
  double get col {
    return _CustomColumnData()._size * this +
        _CustomColumnData()._gutter * max(0, this - 1);
  }

  double get gutter {
    return _CustomColumnData()._gutter * this;
  }
}
