import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../data/content.dart';
import '../theme.dart';
import '../widgets/hover_card.dart';
import '../widgets/qa_bot.dart';
import '../widgets/reveal.dart';
import '../widgets/tech_marquee.dart';
import '../widgets/test_run_card.dart';
import '../widgets/typed_roles.dart';

Duration _d(int ms) => Duration(milliseconds: ms);

class Hero extends StatefulWidget {
  const Hero({super.key, required this.onNavigate});

  final void Function(String id) onNavigate;

  @override
  State<Hero> createState() => _HeroState();
}

class _HeroState extends State<Hero> {
  // Pointer over the hero, normalised to -1…1; drives the robot's head and eyes.
  final _look = ValueNotifier<Offset>(Offset.zero);

  void _onHover(PointerEvent e, Size size) {
    if (e.kind == PointerDeviceKind.touch) return;
    _look.value = Offset(
      ((e.localPosition.dx / size.width) * 2 - 1).clamp(-1.0, 1.0),
      ((e.localPosition.dy / size.height) * 2 - 1).clamp(-1.0, 1.0),
    );
  }

  @override
  void dispose() {
    _look.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);
    final g = gutter(context);
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: C.line))),
      child: ClipRect(
        child: Stack(
          children: [
            const Positioned.fill(child: _HeroBackdrop()),
            Column(
              children: [
                LayoutBuilder(
                  builder: (context, box) => MouseRegion(
                    onHover: (e) => _onHover(e, Size(box.maxWidth, math.max(box.maxHeight, 600))),
                    onExit: (_) => _look.value = Offset.zero,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: kMaxWidth),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(g, narrow ? 72 : 112, g, narrow ? 64 : 96),
                          child: narrow
                              ? Column(
                                  children: [
                                    _copy(context),
                                    const SizedBox(height: 48),
                                    _visual(),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(flex: 115, child: _copy(context)),
                                    const SizedBox(width: 64),
                                    Expanded(flex: 100, child: _visual()),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const TechMarquee(items: techStack),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rise(int ms, Widget child) => Reveal(immediate: true, delay: _d(ms), dy: 24, duration: _d(900), child: child);

  Widget _copy(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h1 = (w * 0.06).clamp(44.0, 72.0);
    final h1Style = sans(h1, weight: FontWeight.w700, height: 1.02, letterSpacing: -0.035 * h1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _rise(100, const _StatusPill()),
        const SizedBox(height: 28),
        _rise(
          250,
          Semantics(
            header: true,
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: 'Test automation that ', style: h1Style),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: _Highlight(text: 'holds up', style: h1Style.copyWith(color: Colors.white)),
                ),
                TextSpan(text: ' in production.', style: h1Style),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 28),
        _rise(
          400,
          Semantics(
            label: 'Specialising in ${heroRoles.join(', ')}',
            child: ExcludeSemantics(
              child: SizedBox(
                height: 28,
                child: Row(
                  children: [
                    Text(r'$ ', style: mono(18, color: C.accentSoft)),
                    Text('specialising in ', style: mono(18, color: C.muted)),
                    const Flexible(child: TypedRoles(roles: heroRoles)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _rise(
          550,
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              "I'm $profileName — a QA automation engineer. I design and build end-to-end and API test "
              'frameworks with TypeScript + Playwright and Java + Selenium/TestNG, wired into your CI/CD '
              'pipeline, with clean architecture your team can maintain.',
              style: sans(19, color: C.lead, height: 1.6),
            ),
          ),
        ),
        const SizedBox(height: 36),
        _rise(
          700,
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              PillButton(label: 'Start a project', trailing: '→', large: true, onTap: () => widget.onNavigate('contact')),
              PillButton(label: 'View case studies', filled: false, large: true, foreground: C.text, onTap: () => widget.onNavigate('projects')),
            ],
          ),
        ),
        const SizedBox(height: 52),
        _rise(
          700,
          Wrap(
            spacing: w < 540 ? 28 : 48,
            runSpacing: 24,
            children: [for (var i = 0; i < heroStats.length; i++) _StatTile(stat: heroStats[i], index: i)],
          ),
        ),
      ],
    );
  }

  Widget _visual() => Reveal(
        immediate: true,
        delay: _d(400),
        dy: 24,
        duration: _d(900),
        child: Column(
          children: [
            QaBot(look: _look),
            Transform.translate(offset: const Offset(0, -6), child: const TestRunCard()),
          ],
        ),
      );
}

class _StatusPill extends StatefulWidget {
  const _StatusPill();

  @override
  State<_StatusPill> createState() => _StatusPillState();
}

class _StatusPillState extends State<_StatusPill> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (!MediaQuery.disableAnimationsOf(context)) _c.repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: C.surf,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: C.line),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: AnimatedBuilder(
                animation: _c,
                builder: (context, _) => Stack(
                  alignment: Alignment.center,
                  children: [
                    // Expanding ring (the `pulse` keyframes).
                    Container(
                      width: 8 + 14 * _c.value,
                      height: 8 + 14 * _c.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x99A05AFF).withValues(alpha: 0.6 * (1 - _c.value)),
                      ),
                    ),
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: C.accent, shape: BoxShape.circle)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Flexible(child: Text('Available for freelance projects', style: mono(13, color: C.muted), overflow: TextOverflow.ellipsis)),
          ],
        ),
      );
}

/// "holds up" with the accent highlighter that sweeps in from the left after the headline lands.
class _Highlight extends StatelessWidget {
  const _Highlight({required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => RevealBuilder(
        immediate: true,
        delay: _d(900),
        duration: _d(800),
        curve: const Cubic(0.7, 0, 0.2, 1),
        builder: (context, t) => Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -6,
              right: -6,
              top: 4,
              bottom: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(widthFactor: t, heightFactor: 1, child: const ColoredBox(color: C.accent)),
              ),
            ),
            Text(text, style: style),
          ],
        ),
      );
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat, required this.index});

  final Stat stat;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width < 540 ? 36.0 : 44.0;
    return Semantics(
      label: '${stat.label}: ${stat.value}',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CountUp(value: stat.value, delay: _d(900 + index * 150), style: sans(size, weight: FontWeight.w700, letterSpacing: -0.03 * size)),
            const SizedBox(height: 4),
            Text(stat.label, style: sans(14, color: C.muted)),
          ],
        ),
      ),
    );
  }
}

/// Counts up to values like "8+", "600+" or "92%"; anything non-numeric is shown as is.
class _CountUp extends StatelessWidget {
  const _CountUp({required this.value, required this.delay, required this.style});

  final String value;
  final Duration delay;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final m = RegExp(r'^(\d+)(.*)$').firstMatch(value);
    if (m == null) return Text(value, style: style);
    final target = int.parse(m.group(1)!);
    final suffix = m.group(2)!;
    return RevealBuilder(
      immediate: true,
      delay: delay,
      duration: _d(1400),
      curve: Curves.easeOutCubic,
      builder: (context, t) => Text('${(target * t).round()}$suffix', style: style),
    );
  }
}

/// Dot grid drifting diagonally, two breathing colour orbs, and a scan line sweeping down.
class _HeroBackdrop extends StatefulWidget {
  const _HeroBackdrop();

  @override
  State<_HeroBackdrop> createState() => _HeroBackdropState();
}

class _HeroBackdropState extends State<_HeroBackdrop> with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker((d) => _secs.value = d.inMicroseconds / 1e6);
  final _secs = ValueNotifier<double>(0);
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (!MediaQuery.disableAnimationsOf(context)) _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _secs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: IgnorePointer(
          child: RepaintBoundary(
            child: ValueListenableBuilder<double>(
              valueListenable: _secs,
              builder: (context, s, _) => CustomPaint(painter: _BackdropPainter(s)),
            ),
          ),
        ),
      );
}

class _BackdropPainter extends CustomPainter {
  _BackdropPainter(this.s);

  final double s;

  @override
  void paint(Canvas canvas, Size size) {
    // Dot grid, 28 px pitch, drifting 280 px per 18 s, fading out over the bottom 40%.
    final drift = (s / 18 * 280) % 28;
    final dots = Paint()..color = const Color(0x1FBEA0FF);
    final fadeStart = size.height * 0.6;
    for (double y = -28 + drift; y < size.height; y += 28) {
      final fade = y <= fadeStart ? 1.0 : (1 - (y - fadeStart) / (size.height - fadeStart)).clamp(0.0, 1.0);
      if (fade <= 0) continue;
      dots.color = const Color(0x1FBEA0FF).withValues(alpha: 0.12 * fade);
      for (double x = -28 + drift; x < size.width; x += 28) {
        canvas.drawCircle(Offset(x, y), 1, dots);
      }
    }

    // Orbs: alternate-direction drift over 14 s, g2 half a cycle behind.
    _orb(canvas, Offset(size.width + 140 - 280, -180 + 280), 280, C.accent, 0.5, _alt(s, 14), const Offset(-70, 50));
    _orb(canvas, Offset(-160 + 220, size.height + 220 - 220), 220, const Color(0xFFC026D3), 0.28, _alt(s + 7, 14), const Offset(-70, 50));

    // Scan line sweeping top → bottom every 7 s.
    final p = (s % 7) / 7;
    final ease = Curves.easeInOutCubic.transform(p);
    final opacity = p < 0.1 ? p / 0.1 * 0.7 : (p > 0.9 ? (1 - p) / 0.1 * 0.7 : 0.7);
    final y = ease * size.height;
    canvas.drawRect(
      Rect.fromLTWH(0, y - 9, size.width, 18),
      Paint()
        ..color = C.accent.withValues(alpha: 0.35 * opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9),
    );
    canvas.drawRect(Rect.fromLTWH(0, y, size.width, 1), Paint()..color = C.accent.withValues(alpha: 0.35 * opacity));
  }

  static double _alt(double s, double period) => 0.5 - 0.5 * math.cos(2 * math.pi * s / (period * 2));

  void _orb(Canvas canvas, Offset center, double radius, Color color, double alpha, double t, Offset travel) {
    final c = center + travel * t;
    final r = radius * (1 + 0.15 * t);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(colors: [color.withValues(alpha: alpha), color.withValues(alpha: 0)]).createShader(Rect.fromCircle(center: c, radius: r)),
    );
  }

  @override
  bool shouldRepaint(_BackdropPainter old) => old.s != s;
}
