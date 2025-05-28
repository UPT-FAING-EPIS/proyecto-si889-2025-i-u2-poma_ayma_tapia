import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424),
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black, // Cambiado a negro
              fontFamily: 'PlusJakartaSans',
            ),
            filled: true,
            fillColor: Colors.white, // Puedes cambiarlo a un gris claro si quieres un tema más oscuro
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder( // Borde por defecto
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2), // Cambiado a negro con opacidad
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder( // Borde cuando está habilitado pero no enfocado
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2), // Cambiado a negro con opacidad
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder( // Borde cuando está enfocado
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black, // Cambiado a negro
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFED533D), width: 1), // Mantenido como rojo para errores
            ),
            suffixIcon: suffixIcon,
          ),
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            color: Color(0xFF242424),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
