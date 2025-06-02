import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
import 'package:frontend/home/home_page.dart'; // Import your HomePage
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(controller: _controller),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0F2027),
                  const Color(0xFF203A43),
                  const Color(0xFF2C5364),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Welcome to CodeXPlay',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            blurRadius: 12,
                            color: Color(0xFF00FFE0),
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 1000.ms)
                        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
                    const SizedBox(height: 12),
                    const Text(
                      'Start your journey by learning to code through fun games!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 1000.ms, delay: 400.ms)
                        .slideY(begin: 0.3, end: 0.0),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: _goToHomePage,
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00C9FF).withOpacity(0.5),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 1000.ms, delay: 800.ms)
                          .slideY(begin: 0.3, end: 0.0)
                          .then()
                          .shimmer(duration: 1500.ms, delay: 1200.ms),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 800.ms).scale(curve: Curves.easeOut),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;
  const AnimatedBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double animationValue;
  final Random _random = Random();

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.2);

    for (int i = 0; i < 60; i++) {
      final x = _random.nextDouble() * size.width;
      final y = (_random.nextDouble() * size.height + animationValue * size.height) % size.height;
      final radius = _random.nextDouble() * 2 + 1;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
