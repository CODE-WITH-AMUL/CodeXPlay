import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
import 'package:frontend/additionalpage/time_page.dart'; // Import the new time_page.dart

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Particle Background
          AnimatedBackground(controller: _controller),
          // Main Content
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1A1A40).withOpacity(0.9),
                  const Color(0xFF4A0D6F).withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo/Title with Enhanced Animation
                  Text(
                    'CodeXPlay',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          blurRadius: 15.0,
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 1200.ms)
                      .scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut)
                      .rotate(begin: -0.1, end: 0.0, duration: 1500.ms),
                  const SizedBox(height: 20),
                  // Tagline with Slide and Fade
                  const Text(
                    'Code. Learn. Play. Repeat!',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 1400.ms, delay: 300.ms)
                      .slideX(begin: -0.5, end: 0.0, curve: Curves.easeOutCubic),
                  const SizedBox(height: 60),
                  // Glassmorphic Get Started Button
                  GestureDetector(
                    onTapDown: (_) => setState(() {}),
                    onTapUp: (_) {
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TimePage()),
                      );
                    },
                    child: AnimatedScale(
                      scale: 1.0,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1.0, 1.0),
                          duration: 1000.ms,
                          curve: Curves.bounceOut,
                        )
                        .fadeIn(delay: 600.ms)
                        .then()
                        .shimmer(duration: 2000.ms, delay: 1200.ms),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Animated Background with Particles
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

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);
    final random = Random(0);

    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = (random.nextDouble() * size.height + animationValue * size.height) % size.height;
      final radius = random.nextDouble() * 2 + 1;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}