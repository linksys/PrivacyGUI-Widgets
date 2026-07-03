part of 'button.dart';

class AppFilledButtonWithLoading extends StatefulWidget {
  final String title;
  final IconData? icon;
  final FutureOr Function()? onTap;
  final Size? size;
  final Color? color;
  final bool? excludeSemantics;
  final bool explicitChildNodes;
  final String? identifier;
  final String? semanticLabel;
  final bool isLoading;

  const AppFilledButtonWithLoading(
    this.title, {
    super.key,
    this.icon,
    this.onTap,
    this.size,
    this.color,
    this.excludeSemantics = false,
    this.explicitChildNodes = false,
    this.identifier,
    this.semanticLabel,
    this.isLoading = false,
  });

  @override
  State<AppFilledButtonWithLoading> createState() =>
      _AppFilledButtonWithLoadingState();
}

class _AppFilledButtonWithLoadingState
    extends State<AppFilledButtonWithLoading> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AppFilledButton(
          isLoading ? '' : widget.title,
          semanticLabel: widget.semanticLabel,
          color: widget.color,
          icon: widget.icon,
          identifier: widget.identifier,
          excludeSemantics: widget.excludeSemantics,
          explicitChildNodes: widget.explicitChildNodes,
          size: widget.size,
          onTap: isLoading
              ? null
              : () async {
                  setState(() {
                    isLoading = true;
                  });
                  await widget.onTap?.call();
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
        ),
        if (isLoading)
          Container(
            width: 24,
            height: 24,
            padding: EdgeInsets.all(Spacing.small1),
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}
