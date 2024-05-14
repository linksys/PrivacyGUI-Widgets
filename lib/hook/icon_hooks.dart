import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:linksys_widgets/utils/named.dart';

//

extension EquatableExtension on Equatable {
  T? getByName<T>(String name) {
    return props
        .whereType<Named?>()
        .firstWhereOrNull((element) => element?.name == name)
        ?.value;
  }
}
