import 'package:flutter/material.dart';
import '../theme/combine_colors.dart';

class CombineFooter extends StatelessWidget {
  const CombineFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  CombineColors.border,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'OUR BENEFACTORS',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              letterSpacing: 6,
              color: CombineColors.textDim,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'UNIVERSAL UNION // EARTH ADMINISTRATION',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 8,
              letterSpacing: 3,
              color: CombineColors.textDim,
            ),
          ),
        ],
      ),
    );
  }
}
