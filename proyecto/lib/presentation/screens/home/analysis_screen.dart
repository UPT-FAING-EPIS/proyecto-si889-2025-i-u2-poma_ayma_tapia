import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Análisis y Estadísticas',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ), // If you want a back button
      ),
      body: Center(
        child: Text(
          'Aquí se mostrarán los análisis y estadísticas.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
