import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme.dart';
import 'hover_card.dart';

/// Sticky glass nav bar. Below 860 px the links collapse into a dropdown menu.
class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.active, required this.onNavigate});

  final ValueListenable<String> active;
  final void Function(String id) onNavigate;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _open = false;

  void _go(String id) {
    setState(() => _open = false);
    widget.onNavigate(id);
  }

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);
    final g = gutter(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xC7120A24),
            border: Border(bottom: BorderSide(color: C.line)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: kMaxWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: g),
                    child: SizedBox(
                      height: kNavHeight - 1,
                      child: Row(
                        children: [
                          _Brand(onTap: () => _go('top')),
                          const Spacer(),
                          if (!narrow)
                            ValueListenableBuilder<String>(
                              valueListenable: widget.active,
                              builder: (context, active, _) => Row(
                                children: [
                                  for (final l in navLinks)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 32),
                                      child: _NavLinkText(link: l, active: active == l.id, onTap: () => _go(l.id)),
                                    ),
                                ],
                              ),
                            ),
                          if (!narrow) const Spacer(),
                          PillButton(label: 'Hire me', onTap: () => _go('contact')),
                          if (narrow) ...[
                            const SizedBox(width: 10),
                            _MenuButton(open: _open, onTap: () => setState(() => _open = !_open)),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (narrow)
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.topCenter,
                  child: _open
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(g, 8, g, 16),
                          color: C.ink,
                          child: ValueListenableBuilder<String>(
                            valueListenable: widget.active,
                            builder: (context, active, _) => Column(
                              children: [
                                for (final l in navLinks)
                                  InkWell(
                                    onTap: () => _go(l.id),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: C.line))),
                                      child: Text(l.label,
                                          style: sans(17, color: active == l.id ? C.accentSoft : C.muted)),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(width: double.infinity),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Semantics(
            link: true,
            label: 'Back to top',
            child: ExcludeSemantics(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: C.accent, borderRadius: BorderRadius.circular(8)),
                    child: Text(profileInitials, style: mono(13, color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  Text(profileHandle, style: mono(15, weight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ),
      );
}

class _NavLinkText extends StatefulWidget {
  const _NavLinkText({required this.link, required this.active, required this.onTap});

  final NavLink link;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavLinkText> createState() => _NavLinkTextState();
}

class _NavLinkTextState extends State<_NavLinkText> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final lit = widget.active || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Semantics(
          link: true,
          selected: widget.active,
          label: widget.link.label,
          child: ExcludeSemantics(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: sans(15, color: lit ? C.text : C.muted),
                  child: Text(widget.link.label),
                ),
                const SizedBox(height: 4),
                // Underline grows from the left when the section is active.
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  height: 2,
                  width: widget.active ? 22 : (_hovered ? 10 : 0),
                  decoration: BoxDecoration(color: C.accent, borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.open, required this.onTap});

  final bool open;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        expanded: open,
        label: 'Toggle menu',
        child: GestureDetector(
          onTap: onTap,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: C.btnBorder),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) => RotationTransition(
                  turns: Tween(begin: 0.75, end: 1.0).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: Icon(open ? Icons.close_rounded : Icons.menu_rounded, key: ValueKey(open), size: 22, color: C.text),
              ),
            ),
          ),
        ),
      );
}
