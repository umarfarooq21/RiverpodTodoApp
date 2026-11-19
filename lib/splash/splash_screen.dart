import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/APIProvider/home_api_future_provider.dart';
import 'package:flutter_riverpod_app/splash/splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _master;
  late final AnimationController _pulse;
  late final AnimationController _orbit;

  late final Animation<double> _fadeIn;
  late final Animation<double> _scaleLogo;
  late final Animation<double> _slideTitle;
  late final Animation<double> _fadeSubtitle;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();

    _master = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _orbit = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();

    _fadeIn = CurvedAnimation(
      parent: _master,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );

    _scaleLogo = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(
        parent: _master,
        curve: const Interval(0.05, 0.45, curve: Curves.easeOutBack),
      ),
    );

    _slideTitle = Tween<double>(begin: 28, end: 0).animate(
      CurvedAnimation(
        parent: _master,
        curve: const Interval(0.28, 0.62, curve: Curves.easeOutCubic),
      ),
    );

    _fadeSubtitle = CurvedAnimation(
      parent: _master,
      curve: const Interval(0.45, 0.8, curve: Curves.easeOut),
    );

    _glow = CurvedAnimation(
      parent: _pulse,
      curve: Curves.easeInOut,
    );

    _master.forward();
    _goHomeWhenReady();
  }

  Future<void> _goHomeWhenReady() async {
    await Future.delayed(const Duration(milliseconds: 3200));
    if (!mounted) return;

    ref.read(splashPhaseProvider.notifier).markReady();

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, animation, secondaryAnimation) =>
            const APIProviderHome(),
            // home: APIProviderHome(), // API uisng Future Provider
            //const HomeCounter(), //stateless work
            //home: const GomeCounter(), //statful counter example using provider
            //home: const HomeScreen(), //simple provider
            //home: const HomeStreamprovider(), //stream provider
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          final fade = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );
          final scale = Tween<double>(begin: 1.04, end: 1.0).animate(fade);
          return FadeTransition(
            opacity: fade,
            child: ScaleTransition(scale: scale, child: child),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _master.dispose();
    _pulse.dispose();
    _orbit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phase = ref.watch(splashPhaseProvider);

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_master, _pulse, _orbit]),
        builder: (context, _) {
          final glow = 0.35 + (_glow.value * 0.35);

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF071A2A),
                  Color(0xFF0B3A4A),
                  Color(0xFF126B6B),
                  Color(0xFF1FA2A2),
                ],
                stops: [0.0, 0.35, 0.7, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Soft floating orbs
                ..._buildOrbs(),

                // Orbiting dots around logo
                Center(
                  child: SizedBox(
                    width: 220,
                    height: 220,
                    child: CustomPaint(
                      painter: _OrbitPainter(
                        progress: _orbit.value,
                        opacity: _fadeIn.value,
                      ),
                    ),
                  ),
                ),

                // Main content
                Center(
                  child: Opacity(
                    opacity: _fadeIn.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.scale(
                          scale: _scaleLogo.value,
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF7EF0E0),
                                  Color(0xFF2EC4B6),
                                  Color(0xFF14919B),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF2EC4B6)
                                      .withValues(alpha: glow),
                                  blurRadius: 36 + (_glow.value * 18),
                                  spreadRadius: 2 + (_glow.value * 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.waves_rounded,
                              size: 54,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Transform.translate(
                          offset: Offset(0, _slideTitle.value),
                          child: Opacity(
                            opacity: (1 - (_slideTitle.value / 28))
                                .clamp(0.0, 1.0),
                            child: const Text(
                              'Riverpod',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Opacity(
                          opacity: _fadeSubtitle.value,
                          child: Text(
                            'Reactive • Elegant • Flutter',
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2.4,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.78),
                            ),
                          ),
                        ),
                        const SizedBox(height: 42),
                        Opacity(
                          opacity: _fadeSubtitle.value,
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white.withValues(
                                  alpha: phase == SplashPhase.ready
                                      ? 0.2
                                      : 0.7,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom tagline
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 48,
                  child: Opacity(
                    opacity: _fadeSubtitle.value,
                    child: Text(
                      'State management, beautifully reactive',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.55),
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildOrbs() {
    final t = _orbit.value * 2 * math.pi;
    return [
      Positioned(
        top: 90 + math.sin(t) * 12,
        left: 36,
        child: _orb(70, 0.10),
      ),
      Positioned(
        top: 160 + math.cos(t * 0.8) * 16,
        right: 24,
        child: _orb(110, 0.08),
      ),
      Positioned(
        bottom: 120 + math.sin(t * 1.3) * 14,
        left: 48,
        child: _orb(90, 0.09),
      ),
      Positioned(
        bottom: 80 + math.cos(t) * 10,
        right: 60,
        child: _orb(55, 0.12),
      ),
    ];
  }

  Widget _orb(double size, double opacity) {
    return Opacity(
      opacity: _fadeIn.value * opacity / 0.12,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: opacity),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7EF0E0).withValues(alpha: opacity),
              blurRadius: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  _OrbitPainter({required this.progress, required this.opacity});

  final double progress;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.white.withValues(alpha: 0.18 * opacity);

    canvas.drawCircle(center, radius, ringPaint);

    for (var i = 0; i < 3; i++) {
      final angle = (progress * 2 * math.pi) + (i * 2 * math.pi / 3);
      final dx = center.dx + radius * math.cos(angle);
      final dy = center.dy + radius * math.sin(angle);

      final dotPaint = Paint()
        ..color = Color.lerp(
          const Color(0xFF7EF0E0),
          Colors.white,
          i / 2,
        )!
            .withValues(alpha: 0.85 * opacity);

      canvas.drawCircle(Offset(dx, dy), 4.5 - (i * 0.6), dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.opacity != opacity;
  }
}
