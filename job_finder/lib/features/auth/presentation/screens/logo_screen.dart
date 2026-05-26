import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LogoScreen extends StatelessWidget {
  final bool fullScreen;

  const LogoScreen({super.key, this.fullScreen = false});

  @override
  Widget build(BuildContext context) {
    final expandedHeight = fullScreen ? MediaQuery.of(context).size.height : null;

    return SizedBox(
      width: double.infinity,
      height: expandedHeight,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Stack(
            children: [
              Positioned(
                top: -40,
                right: -40,
                child: _GlowCircle(color: AppColors.primaryLight.withOpacity(0.18), size: 180),
              ),
              Positioned(
                bottom: -50,
                left: -30,
                child: _GlowCircle(color: AppColors.accent.withOpacity(0.16), size: 150),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 20,
                            offset: Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Jobspot',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
