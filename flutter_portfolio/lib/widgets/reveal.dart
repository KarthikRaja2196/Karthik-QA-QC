import 'dart:async';

import 'package:flutter/material.dart';

/// Runs a 0→1 animation once, the first time the widget scrolls into view
/// (or straight away with [immediate]). Under reduced motion it jumps to 1.
class RevealBuilder extends StatefulWidget {
  const RevealBuilder({
    super.key,
    required this.builder,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.immediate = false,
    this.threshold = 0.92,
  });

  final Widget Function(BuildContext context, double t) builder;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final bool immediate;

  /// Fraction of the viewport height; the widget starts once its top passes this line.
  final double threshold;

  @override
  State<RevealBuilder> createState() => _RevealBuilderState();
}

class _RevealBuilderState extends State<RevealBuilder> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: widget.duration);
  ScrollPosition? _pos;
  Timer? _delay;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pos?.removeListener(_check);
    _pos = widget.immediate ? null : Scrollable.maybeOf(context)?.position;
    _pos?.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_started || !mounted) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _started = true;
      _c.value = 1;
      return;
    }
    if (!widget.immediate) {
      final box = context.findRenderObject();
      if (box is! RenderBox || !box.attached || !box.hasSize) return;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top > MediaQuery.sizeOf(context).height * widget.threshold) return;
    }
    _started = true;
    _delay = Timer(widget.delay, () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _delay?.cancel();
    _pos?.removeListener(_check);
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _c,
        builder: (context, _) => widget.builder(context, widget.curve.transform(_c.value)),
      );
}

/// Fade + rise (+ a touch of scale) entrance, the Flutter twin of `.rise` / `.reveal`.
class Reveal extends StatelessWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.dy = 40,
    this.immediate = false,
    this.duration = const Duration(milliseconds: 800),
  });

  final Widget child;
  final Duration delay;
  final double dy;
  final bool immediate;
  final Duration duration;

  @override
  Widget build(BuildContext context) => RevealBuilder(
        delay: delay,
        immediate: immediate,
        duration: duration,
        builder: (context, t) => Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * dy),
            child: Transform.scale(scale: 0.98 + 0.02 * t, child: child),
          ),
        ),
      );
}
