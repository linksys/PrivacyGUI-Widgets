import 'package:privacygui_widgets/widgets/tree/impl/router_tree_model.dart';
import 'package:privacygui_widgets/widgets/tree/tree_node_view.dart';

class RouterTreeNodeView extends TreeNodeView<UIRouterTreeData> {
  RouterTreeNodeView({
    super.key,
    required super.data,
    super.lineOffsetX,
    super.linePaint,
    super.empty,
    super.topPadding,
    super.indent,
    super.rowHeight,
    required super.nodeBuilder,
  }) : super(
            lineStyle: (data) =>
                data.isOnline ? LineStyle.solid : LineStyle.dottedCross);
}
