import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme.dart';

/// Endless horizontal ticker (32 s per loop) that pauses while the pointer is over it.
class TechMarquee extends StatefulWidget {
  const TechMarquee({super.key, required this.items});

  final List<String> items;

  @override
  State<TechMarquee> createState() => _TechMarqueeState();
}

class _TechMarqueeState extends State<TechMarquee> with SingleTickerProviderStateMixin {
  static const _loop = 32.0;

  final _sc = ScrollController();
  late final Ticker _ticker = createTicker(_onTick);
  Duration _last = Duration.zero;
  double _progress = 0;
  bool _paused = false;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (!MediaQuery.disableAnimationsOf(context)) _ticker.start();
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    if (_paused || !_sc.hasClients) return;
    final pos = _sc.position;
    // The row holds the list twice, so one list's width is (extent + viewport) / 2.
    final half = (pos.maxScrollExtent + pos.viewportDimension) / 2;
    _progress = (_progress + dt / _loop) % 1;
    _sc.jumpTo((_progress * half).clamp(0.0, pos.maxScrollExtent));
  }

  @override
  void dispose() {
    _ticker.dispose();
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doubled = [...widget.items, ...widget.items];
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: C.line))),
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: MouseRegion(
        onEnter: (_) => _paused = true,
        onExit: (_) => _paused = false,
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (rect) => const LinearGradient(
            colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
            stops: [0, 0.1, 0.9, 1],
          ).createShader(rect),
          child: SizedBox(
            height: 24,
            child: Semantics(
              label: 'Tech stack: ${widget.items.join(', ')}',
              child: ExcludeSemantics(
                child: SingleChildScrollView(
                  controller: _sc,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      for (final m in doubled)
                        Padding(
                          padding: const EdgeInsets.only(right: 28),
                          child: Row(
                            children: [
                              Text(m, style: mono(15, color: C.muted)),
                              const SizedBox(width: 28),
                              Text('✦', style: mono(15, color: C.accentSoft)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
