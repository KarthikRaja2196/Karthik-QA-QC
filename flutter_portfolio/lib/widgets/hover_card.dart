import 'package:flutter/material.dart';

import '../theme.dart';

/// Card that lifts, brightens its border and glows on hover (the `.card:hover` rule).
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.builder,
    this.radius = 18,
    this.padding = EdgeInsets.zero,
  });

  final Widget Function(BuildContext context, bool hovered) builder;
  final double radius;
  final EdgeInsetsGeometry padding;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final h = _hovered;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, h ? -6 : 0, 0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: h ? C.surfHover : C.surf,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(color: h ? C.accent : C.line),
          boxShadow: h
              ? const [BoxShadow(color: C.accent, blurRadius: 60, spreadRadius: -24, offset: Offset(0, 24))]
              : const [],
        ),
        child: widget.builder(context, h),
      ),
    );
  }
}

/// Pill-shaped button used across the page. [filled] = accent background, otherwise outlined.
class PillButton extends StatefulWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.filled = true,
    this.large = false,
    this.background,
    this.foreground = Colors.white,
    this.borderColor,
    this.trailing,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;
  final bool large;
  final Color? background;
  final Color foreground;
  final Color? borderColor;
  final String? trailing;

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.background ?? (widget.filled ? C.accent : Colors.transparent);
    final border = widget.borderColor ?? (widget.filled ? null : C.btnBorder);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Semantics(
          button: true,
          label: widget.label,
          child: ExcludeSemantics(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
              constraints: BoxConstraints(minHeight: widget.large ? 52 : 44),
              padding: EdgeInsets.symmetric(horizontal: widget.large ? 28 : 20),
              decoration: BoxDecoration(
                color: _hovered && !widget.filled && widget.background == null
                    ? const Color(0x0FE8EDE6)
                    : bg,
                borderRadius: BorderRadius.circular(999),
                border: border == null ? null : Border.all(color: border, width: widget.borderColor != null ? 2 : 1),
                boxShadow: _hovered && widget.filled && widget.background == null
                    ? const [BoxShadow(color: C.accent, blurRadius: 34, spreadRadius: -8, offset: Offset(0, 12))]
                    : const [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.label,
                      overflow: TextOverflow.ellipsis,
                      style: sans(widget.large ? 16 : 15, weight: FontWeight.w600, color: widget.foreground),
                    ),
                  ),
                  if (widget.trailing != null) ...[
                    const SizedBox(width: 10),
                    Text(widget.trailing!, style: sans(widget.large ? 16 : 15, weight: FontWeight.w600, color: widget.foreground)),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
