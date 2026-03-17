import 'package:flutter/material.dart';
import '../theme/combine_colors.dart';

class StatusGrid extends StatelessWidget {
  final int scansCompleted;

  const StatusGrid({super.key, required this.scansCompleted});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _statusCard('SECTOR', '17-B')),
        const SizedBox(width: 8),
        Expanded(child: _statusCard('SCANS', '$scansCompleted')),
        const SizedBox(width: 8),
        Expanded(child: _statusCard('UPLINK', 'ACTIVE')),
      ],
    );
  }

  Widget _statusCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CombineColors.panelBg,
        border: Border.all(color: CombineColors.border),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              letterSpacing: 2,
              color: CombineColors.textDim,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: CombineColors.cyan,
            ),
          ),
        ],
      ),
    );
  }
}
