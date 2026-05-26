import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback? onArrowTap;

  const SplashScreen({super.key, this.onArrowTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 260,
              height: 260,
              child: Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 34, height: 1.0),
              children: const [
                TextSpan(text: 'Find Your\n'),
                TextSpan(
                  text: 'Dream Job\n',
                  style: TextStyle(color: AppColors.accent),
                ),
                TextSpan(text: 'Here!'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: 330,
            child: Text(
              'Explore all the most exciting job roles based on your interest and study major.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 36),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onArrowTap,
              child: Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
