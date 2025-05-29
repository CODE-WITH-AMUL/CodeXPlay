import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
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
          // Main Content with Glassmorphic Container
          Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
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
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title with Staggered Animation
                  const Text(
                    'Your Notifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          blurRadius: 15.0,
                          color: Color(0xFF00DDEB),
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 1000.ms)
                      .scale(
                        begin: Offset(0.7, 0.7),
                        end: Offset(1.0, 1.0),
                        curve: Curves.easeOutBack,
                      ),
                  const SizedBox(height: 16),
                  // Subtitle
                  const Text(
                    'Stay on track with your coding reminders!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 1000.ms, delay: 400.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0.0,
                        curve: Curves.easeOutCubic,
                      ),
                  const SizedBox(height: 32),
                  // Placeholder Notification List
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: const Text(
                      'No notifications yet.\nSet a reminder on the previous page!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 1000.ms, delay: 800.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0.0,
                        curve: Curves.easeOutCubic,
                      ),
                  const SizedBox(height: 24),
                  // Back Button
                  GestureDetector(
                    onTapDown: (_) => setState(() {}),
                    onTapUp: (_) {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: AnimatedScale(
                      scale: 1.0,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF2D55).withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF2D55), Color(0xFFFF6B6B)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 1000.ms, delay: 1000.ms)
                        .slideY(
                          begin: 0.3,
                          end: 0.0,
                          curve: Curves.easeOutCubic,
                        )
                        .then()
                        .shimmer(duration: 1500.ms, delay: 1400.ms),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms).scale(curve: Curves.easeOut),
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0D0221).withOpacity(0.95),
            const Color(0xFF2A1B3D).withOpacity(0.95),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            painter: ParticlePainter(controller.value),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double animationValue;

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);
    final basePaint = Paint()..color = Colors.white.withOpacity(0.4);
    final glowPaint = Paint()
      ..color = const Color(0xFF00DDEB).withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

    for (int i = 0; i < 60; i++) {
      final x = random.nextDouble() * size.width;
      final y = (random.nextDouble() * size.height + animationValue * size.height * 1.5) % size.height;
      final radius = random.nextDouble() * 3 + 1;
      final glowRadius = radius * 3;

      canvas.drawCircle(Offset(x, y), glowRadius, glowPaint);
      canvas.drawCircle(Offset(x, y), radius, basePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}