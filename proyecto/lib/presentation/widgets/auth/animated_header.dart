import 'package:flutter/material.dart';

class AnimatedHeader extends StatelessWidget {
  final AnimationController gradientController;
  final Animation<Color?> gradientStart;
  final Animation<Color?> gradientEnd;
  final List<dynamic> bubbles; // Usa tu clase _Bubble
  final Widget child;

  const AnimatedHeader({
    super.key,
    required this.gradientController,
    required this.gradientStart,
    required this.gradientEnd,
    required this.bubbles,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Define los colores para las burbujas aquí mismo
    final List<Color> localBubbleColors = [
      const Color(0xFF377CC8), // Azul
      const Color(0xFF469B88), // Verde
      const Color(0xFFE0533D), // Rojo
      const Color(0xFF9DA7D0), // Azul claro
      const Color(0xFFEED868), // Amarillo
      const Color(0xFFE78C9D), // Rosa
    ];

    return AnimatedBuilder(
      animation: gradientController,
      builder: (context, _) {
        return Container(
          height: 240,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                gradientStart.value ?? Colors.black, // Cambiado a negro
                gradientEnd.value ?? const Color(0xFF2C2C2C), // Cambiado a un gris oscuro
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Stack(
            children: [
              ...bubbles.asMap().entries.map((entry) {
                int idx = entry.key;
                var bubble = entry.value; // Asumimos que bubble tiene .left, .top, .size
                return Positioned(
                  left: bubble.left * MediaQuery.of(context).size.width,
                  top: bubble.top * 240,
                  child: Container(
                    width: bubble.size,
                    height: bubble.size,
                    decoration: BoxDecoration(
                      color: localBubbleColors[idx % localBubbleColors.length], // Usa el color de la lista local
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
              child,
            ],
          ),
        );
      },
    );
  }
}
