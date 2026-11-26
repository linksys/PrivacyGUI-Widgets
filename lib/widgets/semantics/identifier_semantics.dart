import 'package:flutter/widgets.dart';

/// Puts [identifier] on a semantics node of its own, where the Flutter 3.27.2
/// web engine writes it to the DOM as `flt-semantics-identifier`. Without an
/// identifier it is [child], and adds no node.
///
/// The 3.27.2 engine drops the identifier of a text field node: its text field
/// role adds no behaviours, so `SemanticRole.update()` returns before it writes
/// the attribute. Later engines fixed this. Around a text field, use
/// [IdentifierSemantics.textField].
class IdentifierSemantics extends StatelessWidget {
  final String? identifier;
  final Widget child;
  final bool _textField;

  /// Around a control other than a text field: the control's own semantics
  /// merge into the identifier's node.
  const IdentifierSemantics({
    super.key,
    required this.identifier,
    required this.child,
  }) : _textField = false;

  /// Around a text field. With a container alone, the identifier's node
  /// merges into the text field node, and the engine drops it again;
  /// `explicitChildNodes` keeps the text field a child node.
  const IdentifierSemantics.textField({
    super.key,
    required this.identifier,
    required this.child,
  }) : _textField = true;

  @override
  Widget build(BuildContext context) {
    final identifier = this.identifier;
    if (identifier == null) return child;
    return Semantics(
      container: true,
      explicitChildNodes: _textField,
      identifier: identifier,
      child: child,
    );
  }
}
