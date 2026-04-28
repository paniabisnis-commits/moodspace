import 'package:flutter/material.dart';

import 'mood_model.dart';

class MoodDecorBackground extends StatelessWidget {
  const MoodDecorBackground({
    super.key,
    required this.child,
    this.showSparkles = true,
  });

  final Widget child;
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
            color: appSecondary.withValues(alpha: 0.18),
          ),
        ),
        Positioned(
          top: 120,
          right: -30,
          child: _blurBlob(
            size: 120,
            color: const Color(0xFFB7C0F4).withValues(alpha: 0.22),
          ),
        ),
        Positioned(
          bottom: -20,
          left: -24,
          child: _blurBlob(
            size: 140,
            color: const Color(0xFFD7DCFA).withValues(alpha: 0.4),
          ),
        ),
        if (showSparkles) ...const [
          Positioned(top: 88, left: 34, child: _Sparkle(size: 22)),
          Positioned(top: 168, right: 40, child: _DoodleDot()),
          Positioned(bottom: 160, left: 32, child: _MiniWave()),
          Positioned(bottom: 88, right: 34, child: _Sparkle(size: 18)),
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
  });

  final Widget child;
  final EdgeInsets padding;

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
                color: appSecondary.withValues(alpha: 0.08),
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
                    color: appPrimary.withValues(alpha: 0.1),
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
  const MoodHeadline(this.title, {super.key, this.center = true});

  final String title;
  final bool center;

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
          decoration: const BoxDecoration(
            color: appSecondary,
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
          decoration: const BoxDecoration(
            color: appPrimary,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.3,
      child: Icon(Icons.auto_awesome_rounded, size: size, color: appPrimary),
    );
  }
}

class _DoodleDot extends StatelessWidget {
  const _DoodleDot();

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
            color: index == 1 ? appPrimary : appSecondary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _MiniWave extends StatelessWidget {
  const _MiniWave();

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
            color: appPrimary.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}
