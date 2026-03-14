import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/combine_colors.dart';
import '../painters/scan_lines_painter.dart';
import '../widgets/combine_header.dart';
import '../widgets/broadcast_panel.dart';
import '../widgets/citizen_scanner.dart';
import '../widgets/threat_level_bar.dart';
import '../widgets/status_grid.dart';
import '../widgets/combine_footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final AnimationController _scanLineCtrl;
  late final AnimationController _radarCtrl;
  late final AnimationController _scanCtrl;

  bool _scanning = false;
  String _scanResult = '';
  Color _resultColor = CombineColors.cyan;
  int _threatLevel = 1;
  int _scansCompleted = 0;
  int _msgIndex = 0;
  bool _glitch = false;
  Timer? _msgTimer;
  Timer? _glitchTimer;

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _radarCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _scanCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..addStatusListener((s) {
        if (s == AnimationStatus.completed) _finishScan();
      });

    _msgTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) {
        setState(
          () => _msgIndex = (_msgIndex + 1) % BroadcastPanel.messages.length,
        );
      }
    });

    _glitchTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted && Random().nextDouble() < 0.4) {
        setState(() => _glitch = true);
        Future.delayed(const Duration(milliseconds: 120), () {
          if (mounted) setState(() => _glitch = false);
        });
      }
    });
  }

  void _startScan() {
    if (_scanning) return;
    setState(() {
      _scanning = true;
      _scanResult = 'SCANNING...';
      _resultColor = CombineColors.cyan;
    });
    _scanCtrl.forward(from: 0);
  }

  void _finishScan() {
    final rng = Random();
    const outcomes = [
      ('CITIZEN COMPLIANT', 0),
      ('THE ONE FREE MAN', 3),
      ('CITIZEN COMPLIANT', 0),
      ('SUSPECT — MONITORING REQUIRED', 1),
      ('NON-COMPLIANT — DETAIN', 2),
      ('ANTI-CITIZEN ONE DETECTED', 3),
    ];
    final pick = outcomes[rng.nextInt(outcomes.length)];
    final color = pick.$2 == 0
        ? CombineColors.green
        : pick.$2 == 1
            ? CombineColors.orange
            : CombineColors.red;

    setState(() {
      _scanning = false;
      _scanResult = pick.$1;
      _resultColor = color;
      _threatLevel = (_threatLevel + pick.$2).clamp(0, 10);
      _scansCompleted++;
    });
  }

  void _resetProtocols() {
    setState(() {
      _threatLevel = 0;
      _scanResult = 'PROTOCOLS RESET';
      _resultColor = CombineColors.cyan;
      _scansCompleted = 0;
    });
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _scanLineCtrl.dispose();
    _radarCtrl.dispose();
    _scanCtrl.dispose();
    _msgTimer?.cancel();
    _glitchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CombineColors.bgDark,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: ScanLinesPainter(_scanLineCtrl)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CombineHeader(
                    pulseAnimation: _pulseCtrl,
                    glitch: _glitch,
                  ),
                  const SizedBox(height: 20),
                  BroadcastPanel(messageIndex: _msgIndex),
                  const SizedBox(height: 20),
                  CitizenScanner(
                    scanning: _scanning,
                    scanResult: _scanResult,
                    resultColor: _resultColor,
                    pulseAnimation: _pulseCtrl,
                    radarAnimation: _radarCtrl,
                    scanAnimation: _scanCtrl,
                    onScan: _startScan,
                  ),
                  const SizedBox(height: 20),
                  ThreatLevelBar(
                    threatLevel: _threatLevel,
                    onReset: _resetProtocols,
                  ),
                  const SizedBox(height: 20),
                  StatusGrid(scansCompleted: _scansCompleted),
                  const SizedBox(height: 20),
                  const CombineFooter(),
                ],
              ),
            ),
          ),
          if (_threatLevel >= 8)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _pulseCtrl,
                  builder: (_, __) => Container(
                    color: CombineColors.red
                        .withOpacity(0.03 + _pulseCtrl.value * 0.05),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
