import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colour tokens, mirroring the `:root` variables in the Vue site's `src/style.css`.
class C {
  static const ink = Color(0xFF120A24);
  static const surf = Color(0xFF1C1236);
  static const surfAlt = Color(0xFF170E2E);
  static const surfHover = Color(0xFF24173F);
  static const line = Color(0xFF2C1F4D);
  static const text = Color(0xFFF5F1FF);
  static const muted = Color(0xFFAEA1D0);
  static const accent = Color(0xFF6D28D9);
  // color-mix(accent 45%, white)
  static const accentSoft = Color(0xFFBD9EEE);
  static const tagBorder = Color(0xFF36285E);
  static const btnBorder = Color(0xFF45347A);
  static const lead = Color(0xFFCBC0E6);
}

const double kNavHeight = 68;
const double kMaxWidth = 1200;

TextStyle sans(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = C.text,
  double? height,
  double letterSpacing = 0,
}) =>
    GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );

TextStyle mono(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = C.text,
  double? height,
}) =>
    GoogleFonts.jetBrainsMono(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );

bool isNarrow(BuildContext context) => MediaQuery.sizeOf(context).width < 860;

double gutter(BuildContext context) => MediaQuery.sizeOf(context).width < 540 ? 18 : 24;
