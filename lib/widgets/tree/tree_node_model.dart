import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class UITreeNodeModel<T> extends TreeViewNode<T> {
  String? tag;
  UITreeNodeModel(
    super.content, {
    super.children,
    this.tag,
  }) : super(expanded: true);

  bool isLast() => this == parent?.children.lastOrNull;
  bool isFirst() => this == parent?.children.firstOrNull;
  bool isRoot() => parent == null;
  bool isLeaf() => children.isEmpty;
  int index() => parent?.children.indexOf(this) ?? -1;
  bool hasSibling() => (parent?.children.length ?? 0) > 1;
}
