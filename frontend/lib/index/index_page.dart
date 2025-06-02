import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const AIContributorApp());
}

class AIContributorApp extends StatelessWidget {
  const AIContributorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Contributor',
      theme: ThemeData(
        primaryColor: const Color(0xFFff0066),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w900,
            color: Color(0xFFe5e5e5),
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            color: Color(0xB3e5e5e5),
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFFff0066),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w900,
            color: Color(0xFFe5e5e5),
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            color: Color(0xB3e5e5e5),
          ),
        ),
      ),
      themeMode: ThemeMode.system, // Default to system theme
      home: const IndexPage(),
    );
  }
}

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _particleCount = 80;
  final _particleOpacity = 0.15;
  bool _isDarkTheme = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 25),
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
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background with particles
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: _isDarkTheme
                    ? [
                        const Color(0xFF2d2d2d),
                        const Color(0xFF1a1a1a),
                        const Color(0xFF0a0a0a),
                      ]
                    : [
                        const Color(0xFFffffff),
                        const Color(0xFFf5f5f5),
                        const Color(0xFFe0e0e0),
                      ],
                stops: const [0.1, 0.5, 1.0],
              ),
            ),
            child: AnimatedBackground(
              controller: _controller,
              particleCount: _particleCount,
              opacity: _particleOpacity,
            ),
          ),

          // Theme toggle button
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isDarkTheme = !_isDarkTheme;
                });
              },
              icon: Icon(
                _isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round,
                color: _isDarkTheme ? Colors.white : Colors.black87,
                size: 24,
              ),
              style: IconButton.styleFrom(
                backgroundColor: _isDarkTheme ? Colors.grey[800] : Colors.grey[200],
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 24.0 : 48.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated title
                      _buildAnimatedTitle(),
                      const SizedBox(height: 16),

                      // Animated tagline
                      _buildAnimatedTagline(),
                      const SizedBox(height: 48),

                      // Get Started button
                      _buildGetStartedButton(context),

                      // Tech icons
                      if (!isSmallScreen) ...[
                        const SizedBox(height: 80),
                        _buildTechIconsRow(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Text(
        'CodeXPlay',
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w900,
          color: _isDarkTheme ? const Color(0xFFe5e5e5) : const Color(0xFF2d2d2d),
          letterSpacing: 1.5,
          height: 0.9,
          shadows: [
            Shadow(
              blurRadius: 20.0,
              color: _isDarkTheme
                  ? Colors.pinkAccent.withOpacity(0.5)
                  : Colors.black26,
              offset: const Offset(0, 5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTagline() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Text(
        'Learn any programming languge',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: _isDarkTheme
              ? const Color(0xB3e5e5e5)
              : const Color(0xB32d2d2d),
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + 0.2 * value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: ElevatedButton(
        onPressed: () {
          // Navigate to dashboard (placeholder)
          // Navigator.pushNamed(context, '/dashboard');
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.pinkAccent.withOpacity(0.5),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFff0066), // Neon pink
                Color(0xFF00ffcc), // Neon cyan
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechIconsRow() {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _buildTechIcon('🐍', 'Python'),
        _buildTechIcon('📚', 'Django'),
        _buildTechIcon('🤖', 'AI'),
        _buildTechIcon('📦', 'GitHub'),
      ].asMap().entries.map((entry) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: entry.value,
        );
      }).toList(),
    );
  }

  Widget _buildTechIcon(String emoji, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isDarkTheme
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            border: Border.all(
              color: _isDarkTheme
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: _isDarkTheme
                ? Colors.white.withOpacity(0.7)
                : Colors.black.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;
  final int particleCount;
  final double opacity;

  const AnimatedBackground({
    super.key,
    required this.controller,
    this.particleCount = 80,
    this.opacity = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(
            controller.value,
            count: particleCount,
            opacity: opacity,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double animationValue;
  final int count;
  final double opacity;
  final Random random = Random(0);

  _ParticlePainter(
    this.animationValue, {
    required this.count,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    for (int i = 0; i < count; i++) {
      final x = random.nextDouble() * size.width;
      final y = (random.nextDouble() * size.height * 1.5 +
              animationValue * size.height * 1.5) %
          (size.height * 1.5);
      final radius = random.nextDouble() * 3 + 1;
      final offset = Offset(x, y);

      // Draw glow effect
      canvas.drawCircle(
          offset, radius * 2, paint..color = Colors.white.withOpacity(opacity * 0.3));
      canvas.drawCircle(
          offset, radius, paint..color = Colors.white.withOpacity(opacity));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}