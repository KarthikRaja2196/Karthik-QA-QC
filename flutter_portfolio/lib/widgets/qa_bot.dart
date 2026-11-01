import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../data/content.dart';
import '../theme.dart';

double _rad(double deg) => deg * math.pi / 180;

/// 0→1→0 over [period] seconds (the `ease-in-out alternate` keyframes in the CSS).
double _wave(double s, double period) => 0.5 - 0.5 * math.cos(2 * math.pi * s / period);

/// The friendly QA robot. [look] is the pointer position over the hero, normalised to -1…1;
/// the head tilts and the eyes follow it.
class QaBot extends StatefulWidget {
  const QaBot({super.key, required this.look});

  final ValueListenable<Offset> look;

  @override
  State<QaBot> createState() => _QaBotState();
}

class _QaBotState extends State<QaBot> with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    final scale = MediaQuery.sizeOf(context).width <= 400 ? 0.9 : 1.0;
    return Semantics(
      label: '3D animated avatar of Karthik as a friendly QA robot holding a passing-test badge',
      image: true,
      child: ExcludeSemantics(
        child: SizedBox(
          width: 320 * scale,
          height: 330 * scale,
          child: FittedBox(
            child: SizedBox(
              width: 320,
              height: 330,
              child: ValueListenableBuilder<Offset>(
                valueListenable: widget.look,
                builder: (context, look, _) => TweenAnimationBuilder<Offset>(
                  tween: Tween(end: look),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  builder: (context, l, _) => ValueListenableBuilder<double>(
                    valueListenable: _secs,
                    builder: (context, s, _) => _scene(s, l),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _scene(double s, Offset l) {
    final float = _wave(s, 4.5);
    final tilt = Matrix4.identity()
      ..setEntry(3, 2, 0.0011)
      ..rotateX(_rad(-l.dy * 12))
      ..rotateY(_rad(l.dx * 18 + (-10 + 20 * float)));
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(child: CustomPaint(painter: _RingPainter(s))),
        Positioned(
          left: 60,
          top: 26,
          width: 200,
          child: Transform(
            alignment: Alignment.center,
            transform: tilt,
            child: Transform.translate(offset: Offset(0, -14 * float), child: _bot(s, l)),
          ),
        ),
        Positioned(
          left: 85,
          bottom: 2,
          width: 150,
          height: 20,
          child: Opacity(
            opacity: 1 - 0.4 * float,
            child: Transform.scale(
              scale: 1 - 0.2 * float,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [Color(0xA6000000), Color(0x00000000)], stops: [0, 0.7]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bot(double s, Offset l) {
    final glow = _wave(s, 1.6);
    // Blink: eyes squash to 10% for a brief moment at 46-50% of every 4.2 s.
    final bt = (s % 4.2) / 4.2;
    final blink = (bt > 0.46 && bt < 0.50) ? 1 - 0.9 * (1 - ((bt - 0.48).abs() / 0.02)) : 1.0;
    final wave = _wave(s, 2.4);
    final armAngle = _rad(-(150 - 32 * wave));
    final checkAngle = _rad(150 - 32 * wave);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Antenna
        SizedBox(
          width: 18,
          height: 32,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFC4B5FD), Color(0xFF7C3AED)],
                  ),
                ),
              ),
              Positioned(
                top: -12,
                child: Transform.scale(
                  scale: 1 + 0.15 * glow,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        center: Alignment(-0.3, -0.4),
                        colors: [Colors.white, Color(0xFFC4B5FD), C.accent],
                        stops: [0, 0.4, 1],
                      ),
                      boxShadow: [BoxShadow(color: C.accent, blurRadius: 18 + 14 * glow, spreadRadius: 4 + 6 * glow)],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Head
        SizedBox(
          width: 200,
          height: 156,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(52),
                    gradient: const RadialGradient(
                      center: Alignment(-0.4, -0.56),
                      radius: 1.1,
                      colors: [Color(0xFFB794FF), Color(0xFF7C3AED), Color(0xFF4C1D95), Color(0xFF2E1065)],
                      stops: [0, 0.38, 0.75, 1],
                    ),
                    boxShadow: const [
                      BoxShadow(color: Color(0xCC4C1D95), blurRadius: 50, spreadRadius: -10, offset: Offset(0, 24)),
                    ],
                  ),
                ),
              ),
              Positioned(left: -14, top: 54, child: _ear()),
              Positioned(right: -14, top: 54, child: _ear()),
              Positioned(
                left: 22,
                right: 22,
                top: 30,
                height: 92,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0x40C4B5FD), width: 3),
                    gradient: const RadialGradient(
                      center: Alignment(0, -1),
                      radius: 1.1,
                      colors: [Color(0xFF2A1650), Color(0xFF0D0620)],
                      stops: [0, 0.7],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        left: 15,
                        child: Transform.rotate(
                          angle: _rad(-8),
                          child: Container(
                            width: 60,
                            height: 12,
                            decoration: BoxDecoration(color: const Color(0x24FFFFFF), borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 17,
                        child: Transform.translate(
                          offset: Offset(l.dx * 8, l.dy * 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _eye(blink),
                              const SizedBox(width: 34),
                              _eye(blink),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 30,
                            height: 13,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Color(0xFFC4B5FD), width: 3),
                                right: BorderSide(color: Color(0xFFC4B5FD), width: 3),
                                bottom: BorderSide(color: Color(0xFFC4B5FD), width: 3),
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Body
        Transform.translate(
          offset: const Offset(0, -8),
          child: SizedBox(
            width: 140,
            height: 96,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(48),
                        bottomRight: Radius.circular(48),
                      ),
                      gradient: const RadialGradient(
                        center: Alignment(-0.4, -0.6),
                        radius: 1.1,
                        colors: [Color(0xFFA78BFA), Color(0xFF6D28D9), Color(0xFF3B0F80)],
                        stops: [0, 0.45, 1],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 45,
                  top: 28,
                  child: Container(
                    width: 50,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: C.ink,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0x66C4B5FD), width: 2),
                      boxShadow: const [BoxShadow(color: Color(0x80A78BFA), blurRadius: 14)],
                    ),
                    child: Text(profileInitials, style: mono(14, weight: FontWeight.w700, color: const Color(0xFFEDE4FF))),
                  ),
                ),
                Positioned(left: -20, top: 16, child: Transform.rotate(angle: _rad(18), alignment: const Alignment(0, -0.8), child: _arm())),
                Positioned(
                  right: -20,
                  top: 16,
                  child: Transform.rotate(
                    angle: armAngle,
                    alignment: const Alignment(0, -0.8),
                    child: SizedBox(
                      width: 26,
                      height: 64,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(child: _arm()),
                          Positioned(
                            bottom: -34,
                            left: -9,
                            child: Transform.rotate(
                              angle: checkAngle,
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF16A34A),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(color: Color(0x2EFFFFFF), spreadRadius: 4),
                                    BoxShadow(color: Color(0x9922C55E), blurRadius: 22, spreadRadius: 4),
                                  ],
                                ),
                                child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _ear() => Container(
        width: 22,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const RadialGradient(
            center: Alignment(-0.2, -0.4),
            radius: 1,
            colors: [Color(0xFFA78BFA), Color(0xFF4C1D95)],
          ),
        ),
      );

  Widget _arm() => Container(
        width: 26,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const RadialGradient(
            center: Alignment(-0.2, -0.5),
            radius: 1,
            colors: [Color(0xFFA78BFA), Color(0xFF4C1D95)],
          ),
        ),
      );

  Widget _eye(double blink) => Transform.scale(
        scaleY: blink,
        child: Container(
          width: 24,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFEDE4FF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Color(0xFFA78BFA), blurRadius: 14, spreadRadius: 3)],
          ),
        ),
      );
}

/// The tilted orbit ring with three glowing dots circling the robot.
class _RingPainter extends CustomPainter {
  _RingPainter(this.s);

  final double s;

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, 170);
    const rx = 150.0;
    final ry = rx * math.cos(_rad(74));
    canvas.drawOval(
      Rect.fromCenter(center: c, width: rx * 2, height: ry * 2),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = const Color(0x66A78BFA),
    );
    final base = 2 * math.pi * s / 9;
    for (final off in const [-math.pi / 2, math.pi * 0.62, 0.0]) {
      final a = base + off;
      final p = c + Offset(rx * math.cos(a), ry * math.sin(a));
      canvas.drawCircle(
        p,
        6,
        Paint()
          ..color = const Color(0xFFC4B5FD)
          ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5),
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.s != s;
}
