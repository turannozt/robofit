import 'package:flutter/material.dart';

// Özel bir InputDecorationTheme örneği
InputDecorationTheme? inputDecorationTheme = InputDecorationTheme(
  // Alan dolu mu kontrolü
  filled: true,
  
  // Etiket metni stilini belirle
  labelStyle: TextStyle(color: Colors.white.withOpacity(.7)),
  
  // Etkileşim olmadığında alt çizgi rengi
  enabledBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  
  // Fokuslandığında alt çizgi rengi
  focusedBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
);
