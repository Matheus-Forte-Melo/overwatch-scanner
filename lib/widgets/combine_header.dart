import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/combine_colors.dart';

class CombineHeader extends StatelessWidget {
  final Animation<double> pulseAnimation;
  final bool glitch;

  const CombineHeader({
    super.key,
    required this.pulseAnimation,
    required this.glitch,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseAnimation,
      builder: (_, __) {
        final g = pulseAnimation.value;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: CombineColors.panelBg,
            border: Border.all(
              color: CombineColors.cyan.withOpacity(0.2 + g * 0.3),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(CombineColors.cyan.withOpacity(0.5 + g * 0.5)),
                  const SizedBox(width: 14),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Transform.translate(
                        offset: glitch
                            ? Offset(Random().nextDouble() * 4 - 2, 0)
                            : Offset.zero,
                        child: Text(
                          glitch ? 'C0MB1NE 0V3RW4TCH' : 'COMBINE OVERWATCH',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 6,
                            color: CombineColors.cyan
                                .withOpacity(0.7 + g * 0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  _dot(CombineColors.cyan.withOpacity(0.5 + g * 0.5)),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      CombineColors.cyan.withOpacity(0.5 + g * 0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'DISPATCH TERMINAL // SECTOR 17-B',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  letterSpacing: 4,
                  color: CombineColors.textDim,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _dot(Color c) => Container(width: 6, height: 6, color: c);
}
