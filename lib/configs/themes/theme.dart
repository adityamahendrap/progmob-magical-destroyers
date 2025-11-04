import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodySmall: GoogleFonts.poppins().copyWith(color: Colors.black),
    bodyMedium: GoogleFonts.poppins().copyWith(color: Colors.black),
    bodyLarge: GoogleFonts.poppins().copyWith(color: Colors.black),
    labelSmall: GoogleFonts.poppins().copyWith(color: Colors.black),
    labelMedium: GoogleFonts.poppins().copyWith(color: Colors.black),
    labelLarge: GoogleFonts.poppins().copyWith(color: Colors.black),
    displaySmall: GoogleFonts.poppins().copyWith(color: Colors.black),
    displayMedium: GoogleFonts.poppins().copyWith(color: Colors.black),
    displayLarge: GoogleFonts.poppins().copyWith(color: Colors.black),
  ),
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.blue,
    secondary: Colors.blueAccent,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodySmall: GoogleFonts.poppins().copyWith(color: Colors.white),
    bodyMedium: GoogleFonts.poppins().copyWith(color: Colors.white),
    bodyLarge: GoogleFonts.poppins().copyWith(color: Colors.white),
    labelSmall: GoogleFonts.poppins().copyWith(color: Colors.white),
    labelMedium: GoogleFonts.poppins().copyWith(color: Colors.white),
    labelLarge: GoogleFonts.poppins().copyWith(color: Colors.white),
    displaySmall: GoogleFonts.poppins().copyWith(color: Colors.white),
    displayMedium: GoogleFonts.poppins().copyWith(color: Colors.white),
    displayLarge: GoogleFonts.poppins().copyWith(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    background: Color(0xFF181A20),
    primary: Colors.blue,
    secondary: Colors.blueAccent,
  ),
);
