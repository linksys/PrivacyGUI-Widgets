import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';
import 'package:privacygui_widgets/widgets/topology/family_tree/custom_buchheim_walker_algorithm.dart';
import 'package:privacygui_widgets/widgets/topology/family_tree/custom_edge_rendener.dart';

import '../tree_node.dart';

typedef NodeBuilder<T> = Widget Function(T);

class AppNode<T> extends Node {
  final T model;
  AppNode.create(this.model, dynamic id) : super.Id(id);
}

class AppFamilyTreeView<T> extends StatefulWidget {
  final AppTreeNode<T> onlineRoot;
  final AppTreeNode<T> offlineRoot;

  final NodeBuilder<AppTreeNode<T>> itemBuilder;

  const AppFamilyTreeView({
    super.key,
    required this.onlineRoot,
    required this.offlineRoot,
    required this.itemBuilder,
  });

  @override
  State<AppFamilyTreeView<T>> createState() => _AppFamilyTreeViewState<T>();
}

class _AppFamilyTreeViewState<T> extends State<AppFamilyTreeView<T>> {
  late final ScrollController _verticalController = ScrollController();

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  @override
  void initState() {
    super.initState();

    //
    _buildGraph(widget.onlineRoot);

    builder
      ..siblingSeparation = (16)
      ..levelSeparation = (48)
      ..subtreeSeparation = (48)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constriant) {
      final gridColumnCount = ResponsiveLayout.isOverExtraLargeLayout(context)
          ? 3
          : ResponsiveLayout.isOverMedimumLayout(context)
              ? 2
              : 1;
      final offlineGridWidth = 300.0 * gridColumnCount;
      final offlineGridHeight =
          84 * ((widget.offlineRoot.children.length / gridColumnCount) + 1);
      return InteractiveViewer(
          constrained: false,
          boundaryMargin:
              const EdgeInsets.symmetric(vertical: 24, horizontal: 100),
          minScale: 1,
          maxScale: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GraphView(
                graph: graph,
                algorithm: CustomBuchheimWalkerAlgorithm(
                  builder,
                  CustomEdgeRenderer(builder),
                  viewWidth: constriant.maxWidth,
                ),
                paint: Paint()
                  ..color = Theme.of(context).colorScheme.outline
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  final appNode = node as AppNode;
                  return widget.itemBuilder(appNode.model);
                },
              ),
              if (widget.offlineRoot.children.isNotEmpty) ...[
                const AppGap.large4(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.itemBuilder(widget.offlineRoot),
                    const AppGap.medium(),
                    SizedBox(
                      width: offlineGridWidth,
                      height: offlineGridHeight,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ResponsiveLayout
                                    .isOverExtraLargeLayout(context)
                                ? 3
                                : ResponsiveLayout.isOverMedimumLayout(context)
                                    ? 2
                                    : 1,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 84,
                          ),
                          itemCount: widget.offlineRoot.children.length,
                          itemBuilder: (context, index) {
                            final node = widget.offlineRoot.children[index];
                            return widget.itemBuilder(node);
                          }),
                    ),
                  ],
                )
              ],
            ],
          ));
    });
  }

  _buildGraph(AppTreeNode<T> root) {
    final node = AppNode.create(root, root.data.toString());
    for (var element in root.children) {
      final childNode = AppNode.create(element, element.data.toString());
      graph.addEdge(node, childNode);
      _buildGraph(element);
    }
  }
}
