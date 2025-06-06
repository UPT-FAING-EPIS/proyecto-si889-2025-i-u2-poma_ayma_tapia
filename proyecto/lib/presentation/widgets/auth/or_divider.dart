import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: Colors.black.withOpacity(0.3), thickness: 1),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'o continúa con',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ),
        Expanded(
          child: Divider(color: Colors.black.withOpacity(0.3), thickness: 1),
        ),
      ],
    );
  }
}
