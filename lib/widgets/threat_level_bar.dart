import 'package:flutter/material.dart';
import '../theme/combine_colors.dart';

class ThreatLevelBar extends StatelessWidget {
  final int threatLevel;
  final VoidCallback onReset;

  const ThreatLevelBar({
    super.key,
    required this.threatLevel,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final (barColor, statusText) = _resolveStatus();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CombineColors.panelBg,
        border: Border.all(
          color: threatLevel >= 8
              ? CombineColors.red.withOpacity(0.5)
              : CombineColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'THREAT ASSESSMENT',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  letterSpacing: 3,
                  color: CombineColors.textDim,
                ),
              ),
              Flexible(
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    color: barColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildBar(barColor),
          const SizedBox(height: 10),
          _buildFooter(barColor),
        ],
      ),
    );
  }

  (Color, String) _resolveStatus() {
    if (threatLevel <= 2) return (CombineColors.green, 'NOMINAL');
    if (threatLevel <= 5) return (CombineColors.orange, 'ELEVATED');
    if (threatLevel <= 7) return (CombineColors.red, 'HIGH');
    return (CombineColors.red, 'CONTAINMENT BREACH IMMINENT');
  }

  Widget _buildBar(Color barColor) {
    return Row(
      children: List.generate(10, (i) {
        final active = i < threatLevel;
        return Expanded(
          child: Container(
            height: 8,
            margin: EdgeInsets.only(right: i < 9 ? 3 : 0),
            decoration: BoxDecoration(
              color: active ? barColor : CombineColors.border,
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: barColor.withOpacity(0.4),
                        blurRadius: 4,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFooter(Color barColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'LEVEL: $threatLevel / 10',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: CombineColors.textPrimary,
          ),
        ),
        if (threatLevel >= 4)
          GestureDetector(
            onTap: onReset,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: CombineColors.cyan.withOpacity(0.3),
                ),
              ),
              child: const Text(
                'RESET PROTOCOLS',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9,
                  letterSpacing: 2,
                  color: CombineColors.cyan,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
