import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme.dart';

/// Fake Playwright run: one test passes every 520 ms, then it holds on the summary and restarts.
class TestRunCard extends StatefulWidget {
  const TestRunCard({super.key});

  @override
  State<TestRunCard> createState() => _TestRunCardState();
}

class _TestRunCardState extends State<TestRunCard> with SingleTickerProviderStateMixin {
  late final AnimationController _float =
      AnimationController(vsync: this, duration: const Duration(seconds: 3));
  Timer? _timer;
  int _step = 0;
  int _wait = 0;
  int _run = 0; // bumps on restart so lines animate in again
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _step = sampleTests.length;
      return;
    }
    _float.repeat(reverse: true);
    _timer = Timer.periodic(const Duration(milliseconds: 520), (_) => _tick());
  }

  // After the last test, hold ~9 ticks on the summary, then restart the run.
  void _tick() {
    setState(() {
      if (_step < sampleTests.length) {
        _step++;
      } else if (_wait < 9) {
        _wait++;
      } else {
        _step = 0;
        _wait = 0;
        _run++;
      }
    });
  }

  void _rerun() => setState(() {
        _step = 0;
        _wait = 0;
        _run++;
      });

  @override
  void dispose() {
    _timer?.cancel();
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final done = _step >= sampleTests.length;
    final frac = _step / sampleTests.length;
    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) {
        final p = Curves.easeInOut.transform(_float.value);
        return Transform.translate(
          offset: Offset(0, -16 * p),
          child: Transform.rotate(angle: -0.6 * p * math.pi / 180, child: child),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: C.surfAlt,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: C.tagBorder),
          boxShadow: const [
            BoxShadow(color: Color(0xA66D28D9), blurRadius: 110, spreadRadius: -30, offset: Offset(0, 40)),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bar(),
            Container(
              constraints: const BoxConstraints(minHeight: 300),
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 8),
              child: Semantics(
                liveRegion: true,
                label: 'Sample test run output',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Running ${sampleTests.length} tests using 4 workers', style: mono(13.5, color: C.muted, height: 1.95)),
                    for (var i = 0; i < _step; i++) _TestLine(key: ValueKey('r$_run-$i'), index: i),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      height: 6,
                      color: C.line,
                      alignment: Alignment.centerLeft,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(end: frac),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        builder: (context, v, _) => FractionallySizedBox(
                          widthFactor: v.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(color: C.accent, borderRadius: BorderRadius.circular(999)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(text: '$_step passed', style: mono(13, weight: FontWeight.w700, color: C.accentSoft)),
                            TextSpan(text: ' · 0 failed · 0 flaky', style: mono(13)),
                          ]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(done ? 'done in 9.5s' : 'running…', style: mono(13, color: C.muted)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: const BoxDecoration(color: C.surf, border: Border(bottom: BorderSide(color: C.line))),
        child: Row(
          children: [
            for (var i = 0; i < 3; i++)
              Container(
                width: 11,
                height: 11,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(color: Color(0xFF4D3B7E), shape: BoxShape.circle),
              ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'npx playwright test --shard=1/4',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: mono(12, color: C.muted),
              ),
            ),
            const SizedBox(width: 12),
            _RerunButton(onTap: _rerun),
          ],
        ),
      );
}

class _TestLine extends StatelessWidget {
  const _TestLine({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final (name, time) = sampleTests[index];
    final reduced = MediaQuery.disableAnimationsOf(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: reduced ? 1 : 0, end: 1),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(-8 * (1 - t), 0), child: child),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text('✓', style: mono(13.5, weight: FontWeight.w700, color: C.accentSoft, height: 1.95)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(name,
                maxLines: 1, overflow: TextOverflow.ellipsis, style: mono(13.5, color: const Color(0xFFE8E1F7), height: 1.95)),
          ),
          const SizedBox(width: 10),
          Text(time, style: mono(13.5, color: const Color(0xFF9285B8), height: 1.95)),
        ],
      ),
    );
  }
}

class _RerunButton extends StatefulWidget {
  const _RerunButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_RerunButton> createState() => _RerunButtonState();
}

class _RerunButtonState extends State<_RerunButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Semantics(
          button: true,
          label: 'Re-run test suite',
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _hovered ? const Color(0x12F5F1FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: C.btnBorder),
              ),
              child: ExcludeSemantics(child: Text('↻ re-run', style: mono(12))),
            ),
          ),
        ),
      );
}
