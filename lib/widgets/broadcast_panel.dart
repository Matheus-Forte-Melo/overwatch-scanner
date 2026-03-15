import 'package:flutter/material.dart';
import '../theme/combine_colors.dart';

class BroadcastPanel extends StatelessWidget {
  final int messageIndex;

  static const messages = [
    'WELCOME. WELCOME TO CITY 17.',
    'YOU HAVE CHOSEN, OR BEEN CHOSEN, TO RELOCATE.',
    'TO RELOCATE TO ONE OF OUR FINEST REMAINING URBAN CENTERS.',
    'I THOUGHT SO MUCH OF CITY 17 THAT I ELECTED TO ESTABLISH MY ADMINISTRATION HERE.',
    'IN THE CITADEL, SO THOUGHTFULLY PROVIDED BY OUR BENEFACTORS.',
    'I HAVE BEEN PROUD TO CALL CITY 17 MY HOME.',
    "IT'S SAFER HERE.",
    'ATTENTION: MISCOUNT DETECTED IN YOUR BLOCK.',
  ];

  const BroadcastPanel({
    super.key,
    required this.messageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CombineColors.panelBg,
        border: Border(
          left: BorderSide(
            color: CombineColors.cyan.withOpacity(0.5),
            width: 3,
          ),
          top: BorderSide(color: CombineColors.border),
          bottom: BorderSide(color: CombineColors.border),
          right: BorderSide(color: CombineColors.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CombineColors.green,
                  boxShadow: [
                    BoxShadow(
                      color: CombineColors.green.withOpacity(0.5),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'BROADCAST ACTIVE',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  letterSpacing: 3,
                  color: CombineColors.textDim,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Text(
              '» ${messages[messageIndex]}',
              key: ValueKey(messageIndex),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                height: 1.6,
                color: CombineColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
