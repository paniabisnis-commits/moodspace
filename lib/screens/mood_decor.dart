import 'package:flutter/material.dart';


class MoodDecorBackground extends StatelessWidget {
  final Widget child;
  final Color accentColor;
  
  const MoodDecorBackground({
    super.key,
    required this.child,
    this.accentColor = const Color(0xFF7C8CF8),
    this.showSparkles = true,
  });

  final bool showSparkles;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -40,
          left: -10,
          child: _blurBlob(
            size: 180,
            color: accentColor.withValues(alpha: 0.18),
          ),
        ),
        Positioned(
          top: 120,
          right: -30,
          child: _blurBlob(
            size: 120,
            color: accentColor.withValues(alpha: 0.22),
          ),
        ),
        Positioned(
          bottom: -20,
          left: -24,
          child: _blurBlob(
            size: 140,
            color: accentColor.withValues(alpha: 0.12),
          ),
        ),
        if (showSparkles) ...[
          Positioned(
            top: 88,
            left: 34,
            child: _Sparkle(size: 22, color: accentColor),
          ),
          Positioned(
            top: 168,
            right: 40,
            child: _DoodleDot(color: accentColor),
          ),
          Positioned(
            bottom: 160,
            left: 32,
            child: _MiniWave(color: accentColor),
          ),
          Positioned(
            bottom: 88,
            right: 34,
            child: _Sparkle(size: 18, color: accentColor),
          ),
        ],
        child,
      ],
    );
  }

  Widget _blurBlob({required double size, required Color color}) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class SectionAccentCard extends StatelessWidget {
  const SectionAccentCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.accentColor = const Color(0xFF7C8CF8),
  });
  final Widget child;
  final EdgeInsets padding;
   final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -14,
            right: -10,
            child: Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -18,
            left: -16,
            child: Transform.rotate(
              angle: -0.3,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.1),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class MoodHeadline extends StatelessWidget {
  const MoodHeadline(this.title, {super.key, this.center = true, this.accentColor = const Color(0xFF7C8CF8),});

  final String title;
  final bool center;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: center
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF33406B),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.7),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class MoodHeader extends StatelessWidget {
  const MoodHeader({
    super.key,
    required this.title,
    required this.icon,
    required this.accentColor,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.85),
            accentColor.withValues(alpha: 0.55),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(color: Colors.white70),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.3,
      child: Icon(Icons.auto_awesome_rounded, size: size, color: color),
    );
  }
}

class _DoodleDot extends StatelessWidget {
  const _DoodleDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: index == 1
                ? color
                : color.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _MiniWave extends StatelessWidget {
  const _MiniWave({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.only(right: 5),
          width: 10,
          height: 4 + (index.isEven ? 7 : 0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}
