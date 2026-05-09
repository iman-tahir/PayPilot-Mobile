import 'package:flutter/material.dart';

// ── Colours — PayPilot HTML theme ────────────────────────────────────────────
// Primary blue (navbar, buttons, accents)
const Color kPrimary      = Color(0xFF1A6EF5);
// Dark navy (card backgrounds, header panels)
const Color kPrimaryDark  = Color(0xFF0D2B6E);
// App background
const Color kBackground   = Color(0xFFF0F3F9);
// Main text
const Color kText         = Color(0xFF0F1C2E);
// Muted / subtext
const Color kTextGrey     = Color(0xFF7393B3);
// Success green (received)
const Color kSuccess      = Color(0xFF00B37E);
const Color kSuccessLight = Color(0xFFE6F9F3);
// Error / danger (sent / failed)
const Color kError        = Color(0xFFE53E3E);
const Color kErrorLight   = Color(0xFFFFF5F5);
// Card fill
const Color kCard         = Colors.white;
// Unread notification badge
const Color kUnread       = Color(0xFFEBF2FF);

// ── Theme ────────────────────────────────────────────────────────────────────
ThemeData appTheme() => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: kPrimary, brightness: Brightness.light),
  scaffoldBackgroundColor: kBackground,
  fontFamily: 'Poppins',
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryDark,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimary,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: kPrimary,
      side: const BorderSide(color: kPrimary, width: 1.5),
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE4E9F2)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE4E9F2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: kPrimary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: kError),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: const TextStyle(color: kTextGrey, fontFamily: 'Poppins'),
    hintStyle: const TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontSize: 14),
  ),
);
