import 'package:flutter/material.dart';

import 'mood_model.dart';

class MoodDecorBackground extends StatelessWidget {
  const MoodDecorBackground({
    super.key,
    required this.child,
    this.accentColor = appPrimary,
    this.showSparkles = true,
  });

  final Widget child;
  final Color accentColor;
  final bool showSparkles;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -12,
          left: -10,
          child: _blurBlob(
            size: 96,
            color: accentColor.withValues(alpha: 0.10),
          ),
        ),
        Positioned(
          top: 96,
          right: -10,
          child: _blurBlob(
            size: 74,
            color: accentColor.withValues(alpha: 0.08),
          ),
        ),
        Positioned(
          bottom: 84,
          right: 18,
          child: _blurBlob(
            size: 54,
            color: accentColor.withValues(alpha: 0.07),
          ),
        ),
        if (showSparkles) ...[
          Positioned(
            top: 84,
            left: 26,
            child: _Sparkle(size: 14, color: accentColor),
          ),
          Positioned(
            top: 136,
            right: 24,
            child: _DoodleDot(color: accentColor),
          ),
          Positioned(
            bottom: 124,
            left: 24,
            child: _MiniWave(color: accentColor),
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
    this.accentColor = appPrimary,
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
      child: child,
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
    this.compact = false,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Color accentColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 18 : 20,
        vertical: compact ? 18 : 22,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.92),
            accentColor.withValues(alpha: 0.68),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: compact ? 46 : 54,
            height: compact ? 46 : 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: compact ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (subtitle != null) ...[
                    const SizedBox(height: 4),

                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.84),
                        fontSize: compact ? 12 : 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }

class InfoScreenHeader extends StatelessWidget {
  const InfoScreenHeader({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withValues(alpha: 0.78),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.white.withValues(alpha: 0.92),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliverPinnedHeader extends SliverPersistentHeaderDelegate {
  SliverPinnedHeader({
    required this.child,
    required this.height,
    this.backgroundColor,
  });

  final Widget child;
  final double height;
  final Color? backgroundColor;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: backgroundColor ?? appBackground,
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPinnedHeader oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.height != height ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}

class ScreenBackButton extends StatelessWidget {
  const ScreenBackButton({
    super.key,
    required this.onTap,
    this.color = appPrimary,
  });

  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.84),
      shape: const CircleBorder(),
      child: IconButton(
        padding: const EdgeInsets.all(12),
        iconSize: 24,
        onPressed: onTap,
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: color,
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({required this.size, required this.color});

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
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: index == 1 ? color : color.withValues(alpha: 0.4),
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
          margin: const EdgeInsets.only(right: 4),
          width: 8,
          height: 3 + (index.isEven ? 5 : 0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.36),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}
