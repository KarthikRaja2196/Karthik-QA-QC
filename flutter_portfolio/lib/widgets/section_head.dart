import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';
import 'reveal.dart';

/// Big outlined number behind section headings (the `.ghost` element).
class GhostNumber extends StatelessWidget {
  const GhostNumber(this.value, {super.key, this.size = 200, this.stroke = const Color(0x47A064FF)});

  final String value;
  final double size;
  final Color stroke;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: Text(
          value,
          // `foreground` and `color` are mutually exclusive, so this bypasses the sans() helper.
          style: GoogleFonts.poppins(
            fontSize: size,
            fontWeight: FontWeight.w800,
            height: 1,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5
              ..color = stroke,
          ),
        ),
      );
}

class SectionHead extends StatelessWidget {
  const SectionHead({
    super.key,
    required this.num,
    required this.label,
    required this.title,
    required this.desc,
  });

  final String num;
  final String label;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);
    final w = MediaQuery.sizeOf(context).width;
    final titleSize = (w * 0.04).clamp(36.0, 52.0);
    return Reveal(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: narrow ? -50 : -78,
              left: -10,
              child: GhostNumber(num, size: w < 540 ? 96 : (narrow ? 130 : 200)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('// $num — $label', style: mono(13, color: C.accentSoft)),
                const SizedBox(height: 14),
                Text(title, style: sans(titleSize, weight: FontWeight.w700, height: 1.08, letterSpacing: -0.03 * titleSize)),
                const SizedBox(height: 18),
                Text(desc, style: sans(18, color: C.muted, height: 1.6)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
