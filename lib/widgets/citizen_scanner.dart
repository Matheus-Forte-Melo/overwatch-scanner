import 'package:flutter/material.dart';
import '../theme/combine_colors.dart';
import '../painters/radar_painter.dart';

class CitizenScanner extends StatelessWidget {
  final bool scanning;
  final String scanResult;
  final Color resultColor;
  final Animation<double> pulseAnimation;
  final Animation<double> radarAnimation;
  final Animation<double> scanAnimation;
  final VoidCallback onScan;

  const CitizenScanner({
    super.key,
    required this.scanning,
    required this.scanResult,
    required this.resultColor,
    required this.pulseAnimation,
    required this.radarAnimation,
    required this.scanAnimation,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CombineColors.panelBg,
        border: Border.all(
          color:
              scanning ? CombineColors.cyan.withOpacity(0.6) : CombineColors.border,
        ),
      ),
      child: Column(
        children: [
          const Text(
            '— CITIZEN IDENTIFICATION —',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              letterSpacing: 4,
              color: CombineColors.textDim,
            ),
          ),
          const SizedBox(height: 20),
          _buildRadar(),
          const SizedBox(height: 20),
          if (scanning) _buildProgress(),
          if (!scanning && scanResult.isNotEmpty) ...[
            const SizedBox(height: 4),
            _buildResult(),
          ],
          const SizedBox(height: 20),
          _buildScanButton(),
        ],
      ),
    );
  }

  Widget _buildRadar() {
    return SizedBox(
      width: 180,
      height: 180,
      child: AnimatedBuilder(
        animation: scanning ? radarAnimation : pulseAnimation,
        builder: (_, __) => CustomPaint(
          painter: RadarPainter(
            sweep: scanning ? radarAnimation.value : -1,
            color: scanning ? CombineColors.cyan : CombineColors.cyanDim,
          ),
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return AnimatedBuilder(
      animation: scanAnimation,
      builder: (_, __) => Column(
        children: [
          LinearProgressIndicator(
            value: scanAnimation.value,
            backgroundColor: CombineColors.border,
            valueColor: const AlwaysStoppedAnimation(CombineColors.cyan),
            minHeight: 3,
          ),
          const SizedBox(height: 8),
          Text(
            '${(scanAnimation.value * 100).toInt()}%',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: CombineColors.cyan,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: resultColor.withOpacity(0.3)),
        color: resultColor.withOpacity(0.05),
      ),
      child: Text(
        scanResult,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          color: resultColor,
        ),
      ),
    );
  }

  Widget _buildScanButton() {
    return GestureDetector(
      onTap: scanning ? null : onScan,
      child: AnimatedBuilder(
        animation: pulseAnimation,
        builder: (_, __) => Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          decoration: BoxDecoration(
            border: Border.all(
              color: scanning
                  ? CombineColors.cyan.withOpacity(0.2)
                  : CombineColors.cyan
                      .withOpacity(0.4 + pulseAnimation.value * 0.3),
              width: 1.5,
            ),
            color: scanning
                ? Colors.transparent
                : CombineColors.cyan.withOpacity(0.08),
          ),
          child: Text(
            scanning ? 'SCANNING...' : 'INITIATE SCAN',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 4,
              color: scanning ? CombineColors.textDim : CombineColors.cyan,
            ),
          ),
        ),
      ),
    );
  }
}
